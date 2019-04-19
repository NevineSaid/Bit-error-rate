% Calculating BER simulation

% a) Generate an array of random bits %10e6 column vector
signal = randi([0,1],[1,1000000])

% noise_mat for different values of SNR, err_mat for #bits that result in
% error
noise_mat = [];
err_mat = [];

%Apply noise to bits
%used 'measured' to calculate signal power
for i = 0:2:30
    noise = awgn(signal,i,'measured');
    noise_mat = [noise_mat; noise];
end

    display(size(noise_mat))
%comparing values of signal to noisy signal using threshold 1/2
for rows = 1:16
    for n = 1:1000000
        if(noise_mat(rows,n)>= 0.5) %threshold
            noise_mat(rows,n) = 1;
        else
            noise_mat(rows,n) = 0;
        end
        
    end
    %biterr compares the 2 signals and returns the number of bits that are
    %different, concatenate all the num_err_bits in one err_mat
    num_err_bits = biterr(signal, noise_mat(rows,:));
    err_mat = [err_mat ; num_err_bits];
    
end   
%calculating BER for every signal and transpose the matrix
BER_ = [err_mat/1000000].';
% display(noise_mat)
% display(err_mat)
% display(BER_)
SNR_ = [0:2:30];

%usng semilogy to plot the SNR against BER
figure
semilogy(SNR_,BER_)