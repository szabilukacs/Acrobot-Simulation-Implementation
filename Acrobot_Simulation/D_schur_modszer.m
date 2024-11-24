function P=D_schur_modszer(A_d,B_d,R,Q)
    H = [A_d+B_d*inv(R)*B_d'*inv(A_d')*Q -B_d*inv(R)*B_d'*inv(A_d');...
        -inv(A_d')*Q inv(A_d')];
    
    n = length(H);
    [V,D] = eig(H);
    [U S] = schur(H);
    [U S] = rsf2csf(U,S);
    index = abs(diag(S));
    [Uv Sv] = schord(U,S,index);
    %Uv
    P = Uv(n/2+1:end,1:n/2) * inv(Uv(1:n/2,1:n/2));
    P = real(P);

end