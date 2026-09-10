function [convMat,paddedImg,convedImg] = getConvMat(h,img)
    assert(mod(size(h,1),2) == 1);
    assert(size(h,1)==size(h,2));
    n = size(img,1); m = size(img,2);
    N = size(h,1); M = size(h,2);
    padl=(size(h,1)-1)/2;
     paddedImg = zeros(n+(N-1),m+(M-1));
     paddedImg(1+padl:n+padl,1+padl:m+padl) = img;
     n = size(paddedImg,1); m = size(paddedImg,2);
    convMat = zeros(n*m);
    for i=1:n
        for j=1:m
            for k = -padl:padl
               for l =-padl:padl
                   if(i+k <= m && i+k >= 1 && j+l <= n && j+l >= 1)
                       convMat((j-1)*m+i,(l+j-1)*m+i+k) = h(l+padl+1,k+padl+1);                       
                   end
               end
            end                  
        end
    end
    
    
    
   
    convedImg = reshape( ...
                          sparse(convMat) * reshape(paddedImg,m*n,1)...
                          ,n,m);
    

end

%     for l = 1:m*n
%         for k = 1:m*n
%             kesi = mod(l,n);
%             yita = (l-kesi)/n +1;
%             p = mod(k,n);
%             q = (k-p)/n+1;
%             if (kesi-p >= 0) && (yita-q >= 0)...
%                && (kesi-p < N) && (yita-q < M)
%              convMat(l,k) = h(kesi - p + 1,yita-q+1); 
%             end
%         end
%     end
%  