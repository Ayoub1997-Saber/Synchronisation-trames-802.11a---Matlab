%{
Projet : Synchronisation en temps 
%}

clc;
clear all;
close all;

%%%%%%% Partie Emetteur %%%%%%%
        %%%% Etape 1 : Construction d'un processus à synchroniser. %%%%
             % 1. Message ternaire %

N = 200;        
trames_emises = real(generation_trame());
message_emetteur = real(construction_message(trames_emises));
subplot(2, 1 ,1); 
plot(message_emetteur, 'Color', [0.8, 0.4, 0.3]);
xlabel('n');
ylabel('x(n)')
title("Message émis");

        %%%% Etape 2 : Passage par un canal de transmission. %%%%
             % 1. Message injecté dans du bruit. %
             
bruit = 0.2 * rand(1, length(message_emetteur)); 
message_recepteur = [bruit bruit bruit message_emetteur+bruit bruit bruit];

subplot(2, 1 ,2);
plot(message_recepteur, 'Color', [0.9, 0.1, 0.3]);
xlabel('n');
ylabel('y(n)')
title("Message reçu");


             % 2. Autocorrélation entre le message émis et le message reçu. %


figure;
plot(xcorr([message_emetteur zeros(1, length(message_recepteur) - length(message_emetteur))], message_recepteur), 'Color', [0.4, 0.5, 0.3], 'LineWidth', 2);            
title("Fonction d'autocorrélation ");
xlabel('p');
ylabel('Ɣ(p)')

             % 3. Extraction de l'information et dé-synchronisation du canal. %


intercorrelation_max = max((xcorr(message_emetteur, message_recepteur)));
position_intercorrelation_max =  find((xcorr(message_emetteur, message_recepteur)) == intercorrelation_max);