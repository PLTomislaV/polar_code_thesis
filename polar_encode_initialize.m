function [out] = polar_encode_initialize(in,E,nMax,iIIL)

K = length(in);

    if iIIL
        pi = nr5g.internal.polar.interleaveMap(K); % interleaving
        inIntr = in(pi+1);
    else
        inIntr = in;
    end

    %[F,qPC] = nr5g.internal.polar.construct(K,E,nMax);
        cl2e = ceil(log2(E));
    if (E <= (9/8) * 2^(cl2e-1)) && (K/E < 9/16)
        n1 = cl2e-1;
    else
        n1 = cl2e;
    end

    rmin = 1/8;
    n2 = ceil(log2(K/rmin));

    nMin = 5;
    n = max(min([n1 n2 nMax]),nMin);
    N = 2^n;
    
    
    if (K>=18 && K<=25)  % for PCC-Polar, 
        nPC = 3;
        if (E-K > 189)
            nPCwm = 1;
        else
            nPCwm = 0;
        end
    else                 % for CA-Polar
        nPC = 0;
        nPCwm = 0;
    end
    
    s10 = nr5g.internal.polar.sequence;
    idx = (s10 < N);
    qSeq = s10(idx);     
    
    % sub-block
       Pi = [0;1;2;4; 3;5;6;7; 8;16;9;17; 10;18;11;19;
          12;20;13;21; 14;22;15;23; 24;25;26;28; 27;29;30;31];

    jn = zeros(N,1); %allocate memory
    for a = 0:N-1 
        i = floor(32*a/N); 
        jn(a+1) = Pi(i+1)*(N/32)+ mod(a,N/32);
    end

    qFtmp = [];
    if E < N
        if K/E <= 7/16  % puncturing
            for i = 0:(N-E-1)
                qFtmp = [qFtmp; jn(i+1)];   
            end
            if E >= 3*N/4
                uLim = ceil(3*N/4-E/2);
                qFtmp = [qFtmp; (0:uLim-1).'];
            else
                uLim = ceil(9*N/16-E/4);
                qFtmp = [qFtmp; (0:uLim-1).'];
            end
            qFtmp = unique(qFtmp);
        else            % shortening
            for i = E:N-1
                qFtmp = [qFtmp; jn(i+1)];   
            end
        end
    end


    qI = zeros(K+nPC,1);
    
    j = 0;
    for i = 1:N
        ind = qSeq(N-i+1);      
        if any(ind==qFtmp) 
            continue;
        end
        j = j+1;
        qI(j) = ind; 
        if j==(K+nPC)
            break;
        end
    end

    % Form the frozen bit vector
    qF = setdiff(qSeq,qI);    

    F = zeros(N,1);
    F(qF+1) = ones(length(qF),1);

    
    out = polar_encode_core(inIntr,F,N,n);
        
end

