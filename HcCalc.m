function HcCalc
%Calculates Hc based on the H12 and H21 data from two runs where the
%positions have been switched.

filename1 = 'Experimental Data/31-May-2016/1.xlsx';
filename2 = 'Experimental Data/31-May-2016/1.xlsx';
sheet1 = 2;
sheet2 = 3;

range = (1500:25:2500);
l = length(range);

H12 = xlsread(filename1, sheet1, sprintf('K2:K%i',l+1)) + i*xlsread(filename1, sheet1, sprintf('L2:L%i',l+1));
H21 = xlsread(filename2, sheet2, sprintf('K2:K%i',l+1)) + i*xlsread(filename2, sheet2, sprintf('L2:L%i',l+1));

Hc = sqrt(H12.*H21);
real(Hc)
imag(Hc)

plot(range, imag(Hc), '--', range, real(Hc), ':', range, abs(Hc))
legend('Imaginary', 'Real', 'Absolute');
end

