%% Teil 1 Vorbereitung
clear;
clc;
Screen('Preference', 'SkipSyncTests', 1);

%% Teil 2 Fenster öffnen
screenNumber = 0;
backgroundColor = [128 128 128];
window = Screen('OpenWindow', screenNumber, backgroundColor);

%% Teil 3 Farben & Bildschirm
white = WhiteIndex(window);
black = BlackIndex(window);

[screenX, screenY] = Screen('WindowSize', window);
centerX = screenX / 2;
centerY = screenY / 2;

%% Stimulusgröße
stimSize = 300;
destRect = CenterRectOnPointd([0 0 stimSize stimSize], centerX, centerY);

%% Fixationskreuz vorbereiten
Screen('TextSize', window, 50);
fixCross = '+';

%% Rauschmaske vorbereiten
noiseImg = uint8(rand(stimSize, stimSize) * 255);
noiseTex = Screen('MakeTexture', window, noiseImg);

%% Gesichter laden
facesPath = '/Users/johanneslager/Desktop/Gesichter';
faceFiles = dir(fullfile(facesPath, '*.jpeg'));
nFaces = length(faceFiles);

%% Anzahl Trials
nTrials = 20;

%% ===TRIAL===
for trial = 1:nTrials

    % Fixationskreuz
    DrawFormattedText(window, fixCross, 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(1);

    % Rauschmaske
    Screen('DrawTexture', window, noiseTex, [], destRect);
    Screen('Flip', window);
    WaitSecs(0.5 + rand * 0.5);

    % Zufälliges Gesicht
    idx = randi(nFaces);
    img = imread(fullfile(facesPath, faceFiles(idx).name));
    tex = Screen('MakeTexture', window, img);

    Screen('DrawTexture', window, tex, [], destRect);
    Screen('Flip', window);
    WaitSecs(0.1);

    Screen('Close', tex); % Texture freigeben

    % Leerer Bildschirm
    Screen('Flip', window);
    WaitSecs(1);

end
%% ======

%% Ende
KbWait;
Screen('CloseAll');
