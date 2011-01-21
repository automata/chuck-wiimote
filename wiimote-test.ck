// wiimote-test.ck
//
// load wiimote.ck first. load this file at your ChucK.
// roll your wiimote to change the sinosoid frequency.
// press wiimote's UP and DOWN to change it's gain.
// have fun!

// let's store wii data at wii instance variable
Wiimote wii;

// starting to update state of wii data. start() sporks many
// shreds for wiimote's events monitoring
wii.start();

// just using a simple sinoidal to demonstration
SinOsc s => dac;

while (true) {

    // testing if UP button is pressed. then increasing the gain.
    if (wii.up()) {
        s.gain() + 0.05 => s.gain;
    }
    
    // testing if DOWN button is pressed. then decreasing the gain.
    if (wii.down()) {
        s.gain() - 0.05 => s.gain;
        if (s.gain() < 0)
            0 => s.gain;
    }
    
    // using the wiimote's roll movement to update the frequency
    s.freq(wii.roll() * 10);

    10::ms => now;
}