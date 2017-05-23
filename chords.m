% initialize matrix:
N = 100;  % num notes
M = zeros(3*N,6);

midiTime = 0;

for i = 1:N
    midiNote = 36 + round(48*rand(1,1));
    randomTime = 0.2 + rand(1,1);
    if rem(midiNote,12)==0
        M(3*i-1,3) = midiNote + 4;
        M(3*i-2,3) = midiNote + 7;
    elseif rem(midiNote,12)==4
        M(3*i-1,3) = midiNote + 3;
        M(3*i-2,3) = midiNote + 8;
    elseif rem(midiNote,12)==7
        M(3*i-1,3) = midiNote + 5;
        M(3*i-2,3) = midiNote + 9;    
    end
    M(3*i-1,5) = midiTime;
    M(3*i-2,5) = midiTime;
    M(3*i-1,6) = midiTime + randomTime;
    M(3*i-2,6) = midiTime + randomTime;
    
    M(3*i,3) = midiNote; % random note numbers
    M(3*i,5) = midiTime; 
    M(3*i,6) = midiTime + randomTime;
    midiTime = midiTime + randomTime;
end

M(:,1) = 1;         % all in track 1
M(:,2) = 1;         % all in channel 1

M(:,4) = 60 + round(40*rand(3*N,1));

midi_new = matrix2midi(M);
writemidi(midi_new, 'Chords.mid');

playMidi('Chords.mid');

midi = readmidi('Chords.mid');

%% convert to 'Notes' matrix:
Notes = midiInfo(midi,0);

%% compute piano-roll:
[PR,t,nn] = piano_roll(Notes);

%% display piano-roll:
figure;
imagesc(t,nn,PR);
axis xy;
xlabel('time (sec)');
ylabel('note number');

%% also, can do piano-roll showing velocity:
[PR,t,nn] = piano_roll(Notes,1);

figure;
imagesc(t,nn,PR);
axis xy;
xlabel('time (sec)');
ylabel('note number');