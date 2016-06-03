function HcCalc
%Calculates Hc based on the H12 and H21 data from two runs where the
%positions have been switched.

d = date;
filename1 = sprintf('Experimental Data/%s/1', d);
filename2 = sprintf('Experimental Data/%s/1', d);
sheet1 = 1;
sheet2 = 2;

range = (1700:25:2300);
l = length(range);

H12 = xlsread(filename1, sheet1, sprintf('K2:K%i',l+1)) + i*xlsread(filename1, sheet1, sprintf('L2:L%i',l+1));
H21 = xlsread(filename2, sheet2, sprintf('K2:K%i',l+1)) + i*xlsread(filename2, sheet2, sprintf('L2:L%i',l+1));

format long g
Hc = sqrt(H12.*H21);
rline = polyfit((1700:25:2300)', real(Hc), 3)
iline = polyfit((1700:25:2300)', imag(Hc), 3)

save Hc rline iline

plot(range, imag(Hc), '--', range, real(Hc), ':', range, abs(Hc))
legend('Imaginary', 'Real', 'Absolute');
end

