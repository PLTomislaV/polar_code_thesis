function [out] = polar_encode_core(in,F,N,n)

    G2 = [1 0; 1 1];
    GN = G2;
    for i = 1:n-1
        GN = kron(GN,G2); %generate correct size of the generator matrix 
    end
    
    u = zeros(N,1);  

        k = 1;
        for idx = 1:N

           if F(idx)==0
               u(idx) = in(k); % Set information bits (interleaved)
               k = k+1;
           else
               u(idx) = 0;
           end
        end

    
    out = mod(u'*GN,2)';

end

