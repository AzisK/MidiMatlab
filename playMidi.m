function playMidi(name)
    midi = readmidi(name);

    %----- converting MIDI to audio ----------

    % (Fs = sample rate. here, uses default 44.1k.)
    [y,Fs] = midi2audio(midi);    

    %% listen in matlab:
    soundsc(y, Fs);  % FM-synth
end