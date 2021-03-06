function Q = MMC_sum_kernels(K, y_set, mu,cost_vec, usebias)
% T = size(y_set,2);
% n = size(K,1);
% M = length(index)-1;
% Q = zeros(n);
% for m = 1 : M
%     idx = [index{m}; index{M+1}];
%     for t = 1 : T
%         if mu(m,t)>eps
%             y = y_set(idx,t);
%             if usebias
%                 Q(idx,idx) = Q(idx,idx) + mu(m,t) * (K(idx,idx,m)+1) .* (y*y');
%             else
%                 Q(idx,idx) = Q(idx,idx) + mu(m,t) * K(idx,idx,m) .* (y*y');
%             end
%         end
%     end
% end
% Q = Q + diag(1./cost_vec);


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Faster implementation
%
T = size(y_set,2);
n = size(K,1);
M = size(K,3);
Q = zeros(n);
for m = 1 : M
    Qm = zeros(size(Q));
    if usebias
        Km = K(:,:,m)+1;
    else
        Km = K(:,:,m);
    end
    for t = 1 : T
        if mu(m,t)>eps
            y = y_set(:,t);          
            Qm = Qm + mu(m,t) * Km .* (y*y');
        end
    end
    Q(:,:) = Q(:,:) + Qm;
end
Q = Q + diag(1./cost_vec);