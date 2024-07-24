function [trames] = generation_trame()

subcarrier_frequency_spacing = 0.3125 * 10 ^ (6); % Delte_f, Page 9. 

number_data_subcarriers = 48;
number_pilot_subcarriers = 4;

number_subcarriers = number_data_subcarriers + number_pilot_subcarriers - 1;% Nst, Page 9.
short_training_sequence_duration = 0.8 * 10 ^ (-6);% Tshort, Page 9.                                                                          

% Porteuse 
s_26 = [];
s_26=sqrt(13/6)*[0, 0, 1+j, 0, 0, 0, -1-j, 0, 0, 0, 1+j, 0, 0, 0, -1-j, 0, 0, 0, -1-j, 0, 0, 0, 1+j, 0, 0, 0, 0,0, 0, 0, -1-j, 0, 0, 0, -1-j, 0, 0, 0, 1+j, 0, 0, 0, 1+j, 0, 0, 0, 1+j, 0, 0, 0, 1+j, 0,0]
%s_26 = sqrt(13/6) .* [0 0 1+j 0 0 0 -1-j 0 0 0 1+j 0 0 0 -1-j 0 0 0 -1-j 0 0 0 1+j 0 0 0 0 0 0 0 -1-j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0 0 1+j 0 0];                 % Sous-porteuses OFDM. 
s_26 = s_26';
distance_trames = 10 ^ -7;                                                                                                                                           % Page 11. (TTr = 100 ns), on prends une valeur egale 100ns

       % 2. Découpage de trame en 3 fenêtres (processus de fenêtrage). %

t1 = -distance_trames / 2 : distance_trames / 10 : distance_trames / 2;                                                                         % Page 10  
t2 = distance_trames / 2 : distance_trames / 10 : short_training_sequence_duration - distance_trames / 2;                                     % Page 10
t3 = short_training_sequence_duration - distance_trames / 2 : distance_trames / 10 : short_training_sequence_duration + distance_trames / 2;  % Page 10
t = [t1 t2 t3];


Wtshort1 = sin (pi / 2 * (0.5 + t1 / distance_trames)) .^ 2;                                      % Page 10 : 1ère fenêtre de la trame.
Wtshort2 = ones(1, length(t2));                                                                   % Page 10 : 2ème fenêtre de la trame.
Wtshort3 = sin (pi / 2 * (0.5 - (t3 - short_training_sequence_duration) / distance_trames)) .^ 2; % Page 10 : 3ème fenêtre de la trame.      
Wtshort = [Wtshort1 Wtshort2 Wtshort3];                                                           % Page 10 : Rassemblage des 3 fenêtres. 

trames=[];
for n = 1 : 10                                                                                    % Page 12 ('n' = symbole)
  total_reel = 0; 
  total_imaginaire = 0; 
  total=0;
  for k = - number_subcarriers / 2 : number_subcarriers / 2
    total = s_26( k + number_subcarriers / 2+1) * exp(j * 2 * pi * k * subcarrier_frequency_spacing .* t) + total;%p13
  end
 short = Wtshort .* total;
 trames = [trames short];
end
end



