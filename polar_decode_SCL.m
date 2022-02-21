function outkpc = polar_decode_SCL(in,F,nL,iIL,crcLen,padCRC,rnti)
    

    
    N = length(F);
    K = sum(F==0);
    A = K - crcLen;

    F2 = zeros(1,N-K);
    o=1;
    for idx=1:N
        if F(idx)==1
            F2(o)=idx;
            o = o+1;
        end
    end
    
    if crcLen == 24         % '24C', downlink
        polyStr = '24C';
    elseif crcLen == 11     % '11', uplink
        polyStr = '11';
    else % crcLen == 6      % '6', uplink
        polyStr = '6';
    end
    

    if iIL
        piInterl = nr5g.internal.polar.interleaveMap(K);
    else
        piInterl = (0:K-1).';
    end
    
    
    
    
    n = log2(N);

    f = @(a,b) (1-2*(a<0)).*(1-2*(b<0)).*min(abs(a),abs(b)); %minsum
    g = @(a,b,c) b+(1-2*c).*a; %g function
    

    
    %nL SC decoders
    LLR = zeros(nL,n+1,N); %beliefs in nL decoders
    ucap = zeros(nL,n+1,N); %decisions in nL decoders
    PML = Inf*ones(nL,1); %Path metrics
    PML(1) = 0;
    ns = zeros(1,2*N-1); %node state vector
    LLR(:,1,:) = repmat(in.',nL,1,1); %belief of root
    DML = zeros(nL,N);
    PMLL = zeros(nL,N);
    
    node = 0; depth = 0; %start at root
    done = 0; %decoder has finished or not
    while (done == 0) %traverse till all bits are decoded
        %leaf or not
        if depth == n
            DM = squeeze(LLR(:,n+1,node+1)); %decision metrics
            DML(:,node+1) = DM;
            PMLL(:,node+1) = PML;
            if any(F2==(node+1)) %is node frozen
                ucap(:,n+1,node+1) = 0; %set all decisions to 0
                PML = PML + abs(DM).*(DM < 0); %if DM is negative, add |DM|
            else
                dec = DM < 0; %decisions as per DM
                PM2 = [PML; PML+abs(DM)];
                [PML, pos] = mink(PM2,nL); %In PM2(:), first nL are as per DM 
                                             %next nL are opposite of DM
                pos1 = pos > nL; %surviving with opposite of DM: 1, if pos is above nL
                pos(pos1) = pos(pos1) - nL; %adjust index
                dec = dec(pos); %decision of survivors
                dec(pos1) = 1 - dec(pos1); %flip for opposite of DM
                LLR = LLR(pos,:,:); %rearrange the decoder states
                ucap = ucap(pos,:,:);
                ucap(:,n+1,node+1) = dec;
            end
            if node == (N-1)
                done = 1;
            else
                node = floor(node/2); depth = depth - 1;
            end
        else
            %nonleaf
            npos = (2^depth-1) + node + 1; %position of node in node state vector
            if ns(npos) == 0 %step L and go to left child
                temp = 2^(n-depth);
                Ln = squeeze(LLR(:,depth+1,temp*node+1:temp*(node+1))); %incoming beliefs
                a = Ln(:,1:temp/2); b = Ln(:,temp/2+1:end); %split beliefs into 2
                node = node *2; depth = depth + 1; %next node: left child
                temp = temp / 2; %incoming belief length for left child
                LLR(:,depth+1,temp*node+1:temp*(node+1)) = f(a,b); %minsum and storage
                ns(npos) = 1;
            else
                if ns(npos) == 1 %step R and go to right child
                    temp = 2^(n-depth);
                    Ln = squeeze(LLR(:,depth+1,temp*node+1:temp*(node+1))); %incoming beliefs
                    a = Ln(:,1:temp/2); b = Ln(:,temp/2+1:end); %split beliefs into 2
                    lnode = 2*node; ldepth = depth + 1; %left child
                    ltemp = temp/2;
                    ucapn = squeeze(ucap(:,ldepth+1,ltemp*lnode+1:ltemp*(lnode+1))); %incoming decisions from left child
                    node = node *2 + 1; depth = depth + 1; %next node: right child
                    temp = temp / 2; %incoming belief length for right child
                    LLR(:,depth+1,temp*node+1:temp*(node+1)) = g(a,b,ucapn); %g and storage
                    ns(npos) = 2;
                else %step U and go to parent
                    temp = 2^(n-depth);
                    lnode = 2*node; rnode = 2*node + 1; cdepth = depth + 1; %left and right child
                    ctemp = temp/2;
                    ucapl = squeeze(ucap(:,cdepth+1,ctemp*lnode+1:ctemp*(lnode+1))); %incoming decisions from left child
                    ucapr = squeeze(ucap(:,cdepth+1,ctemp*rnode+1:ctemp*(rnode+1))); %incoming decisions from right child
                    ucap(:,depth+1,temp*node+1:temp*(node+1)) = [mod(ucapl+ucapr,2) ucapr]; %combine
                    node = floor(node/2); depth = depth - 1;
                end
            end
        end
    end
    
    
    msg_capl = squeeze(ucap(:,n+1,1:end)); %get candidate messages
    msg_cap = zeros(K,nL);
    for c3 = 1:nL %deinterleave
        one_ = msg_capl(c3,1:end);
        decCW = one_.';
        dec = decCW(F==0,1); 
        dec(piInterl+1) = dec;  
        msg_cap(1:end,c3)=dec.';
    end

    
    %check CRC
    cout = 1; %candidate codeword to be outputted, initially set to best PM
    for c1 = 1:nL
            if padCRC  % prepad with ones
                padCRCMsg = [ones(crcLen,1); msg_cap(1:end,c1)];
            else
                padCRCMsg = msg_cap(1:end,c1);
            end
            [~, errFlag] = nrCRCDecode(padCRCMsg,polyStr,rnti);
        if isequal(errFlag,0) %check if CRC passes
            cout = c1;
            break
        end
    end
    outkpc = msg_cap(1:A,cout);

end


