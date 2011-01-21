// chuck-wiimote.ck ~ v0.01 ~ <http://automata.cc/chuck-wiimote>

public class Wiimote {
    
    // constants for buttons/flags from Wii and Nunchuk
    0 => int A; 1 => int B;
    2 => int UP; 3 => int DOWN;
    4 => int LEFT; 5 => int RIGHT;
    6 => int ONE; 7 => int TWO;
    8 => int PLUS; 9 => int MINUS;
    10 => int HOME;
    11 => int C; 12 => int Z;
    13 => int CONNECTED;
    
    // store the buttons/flags data
    int buttons[14];
    
    // store the continuous data
    float wiiRoll;
    float wiiPitch;
    float wiiAccX;
    float wiiAccY;
    float wiiAccZ;
    float wiiBattery;
    float nunchukRoll;
    float nunchukPitch;
    float nunchukAccX;
    float nunchukAccY;
    float nunchukAccZ;
    float nunchukJoyX;
    float nunchukJoyY;
    
    // listen to events on default darwiinRemoteOSC port (5600)
    OscRecv recv;
    5600 => recv.port;
    recv.listen();
    
    // store the buttons/flags events data
    OscEvent e[14];
    
    // all events to Wii and Nunchuk
    recv.event("/wii/button/a, i") @=> e[A] @=> OscEvent eA;
    recv.event("/wii/button/b, i") @=> e[B] @=> OscEvent eB;
    recv.event("/wii/button/up, i") @=> e[UP] @=> OscEvent eUp;
    recv.event("/wii/button/down, i") @=> e[DOWN] @=> OscEvent eDown;
    recv.event("/wii/button/left, i") @=> e[LEFT] @=> OscEvent eLeft;
    recv.event("/wii/button/right, i") @=> e[RIGHT] @=> OscEvent eRight;
    recv.event("/wii/button/one, i") @=> e[ONE] @=> OscEvent eOne;
    recv.event("/wii/button/two, i") @=> e[TWO] @=> OscEvent eTwo;
    recv.event("/wii/button/plus, i") @=> e[PLUS] @=> OscEvent ePlus;
    recv.event("/wii/button/minus, i") @=> e[MINUS] @=> OscEvent eMinus;
    recv.event("/wii/button/home, i") @=> e[HOME] @=> OscEvent eHome;
    recv.event("/wii/connected, i") @=> e[CONNECTED] @=> OscEvent eConnected;
    recv.event("/wii/acc, fff") @=> OscEvent eWiiAcc;
    recv.event("/wii/orientation, ff") @=> OscEvent eWiiOrientation;
    recv.event("/wii/irdata, fffffffffff") @=> OscEvent eWiiIr;
    recv.event("/wii/batterylevel, f") @=> OscEvent eWiiBattery;
    
    // nunchuk events
    recv.event("/nunchuk/button/z, i") @=> e[Z] @=> OscEvent eNckZ;
    recv.event("/nunchuk/button/c, i") @=> e[C] @=> OscEvent eNckC;
    recv.event("/nunchuk/joystick, ff") @=> OscEvent eNckJoystick;
    recv.event("/nunchuk/acc, fff") @=> OscEvent eNckAcc;
    recv.event("/nunchuk/orientation, ff") @=> OscEvent eNckOrientation;
    
    // interface methods
    fun int connected() {
        return buttons[CONNECTED];
    }

    fun int a() {
        return buttons[A];
    }
    
    fun int b() {
        return buttons[B];
    }
    
    fun int up() {
        return buttons[UP];
    }
    
    fun int down() {
        return buttons[DOWN];
    }
    
    fun int left() {
        return buttons[LEFT];
    }
    
    fun int right() {
        return buttons[RIGHT];
    }
    
    fun int minus() {
        return buttons[MINUS];
    }
    
    fun int plus() {
        return buttons[PLUS];
    }
    
    fun int home() {
        return buttons[HOME];
    }
    
    fun int one() {
        return buttons[ONE];
    }
    
    fun int two() {
        return buttons[TWO];
    }
    
    fun float accX () {
        return wiiAccX;
    }
    
    fun float accY () {
        return wiiAccY;
    }
    
    fun float accZ () {
        return wiiAccZ;
    }
    
    fun float roll() {
        return wiiRoll;
    }
    
    fun float pitch() {
        return wiiPitch;
    }
    
    // irdata not implemented yet.
    
    fun float battery() {
        return wiiBattery;
    }
    
    fun float nckJoyX() {
        return nunchukJoyX;
    }
    
    fun float nckJoyY() {
        return nunchukJoyY;
    }
    
    fun int z() {
        return buttons[Z];
    }
    
    fun int c() {
        return buttons[C];
    }
    
    fun float nckAccX() {
        return nunchukAccX;
    }
    
    fun float nckAccY() {
        return nunchukAccY;
    }
    
    fun float nckAccZ() {
        return nunchukAccZ;
    }
    
    fun float nckRoll() {
        return nunchukRoll;
    }
    
    fun float nckPitch() {
        return nunchukPitch;
    }
    
    // internal methods
    fun void updateWiiBattery() {
        while (true) {
            eWiiBattery => now;
            
            eWiiBattery.nextMsg();
            
            eWiiBattery.getFloat() => wiiBattery;
        }
    }
    
    fun void updateWiiOrientation() {
        while ( true ) {
            eWiiOrientation => now;
            
            //advance message
            eWiiOrientation.nextMsg();
            
            eWiiOrientation.getFloat() => wiiRoll;
            eWiiOrientation.getFloat() => wiiPitch;
        }
    }
    
    fun void updateNckOrientation() {
        while ( true ) {
            eNckOrientation => now;
            
            //advance message
            eNckOrientation.nextMsg();
            
            eNckOrientation.getFloat() => nunchukRoll;
            eNckOrientation.getFloat() => nunchukPitch;
        }
    }    
    
    fun void updateWiiAcceleration() {
        while ( true ) {
            eWiiAcc => now;
            
            //advance message
            eWiiAcc.nextMsg();
            
            eWiiAcc.getFloat() => wiiAccX;
            eWiiAcc.getFloat() => wiiAccY;
            eWiiAcc.getFloat() => wiiAccZ;
        }
    }    

    fun void updateNckAcceleration() {
        while ( true ) {
            eNckAcc => now;
        
            // advance message
            eNckAcc.nextMsg();
        
            eNckAcc.getFloat() => nunchukAccX;
            eNckAcc.getFloat() => nunchukAccY;
            eNckAcc.getFloat() => nunchukAccZ;
        }
    }

    fun void updateNckJoystick() {
        while ( true ) {
            eNckJoystick => now;
        
            // advance message
            eNckJoystick.nextMsg();
        
            eNckJoystick.getFloat() => nunchukJoyX;
            eNckJoystick.getFloat() => nunchukJoyY;
        }
    }
    
    fun void updateButton(int pos) {
        e[pos] @=> OscEvent ev;
        while ( true )
        {
            ev => now; 
            while( ev.nextMsg() != 0 ) {}
            
            ev.getInt() => buttons[pos];
        }
    }
    
    // starting methods
    fun void updateWii() {
        for (0 => int i; i<11; i++) {
            spork ~ updateButton(i);
        }
        
        spork ~ updateWiiAcceleration();
        spork ~ updateWiiOrientation();
    }
    
    fun void updateNck() {
        for (11 => int i; i < 13; i++) {
            spork ~ updateButton(i);
        }
        
        spork ~ updateNckAcceleration();
        spork ~ updateNckOrientation();
        spork ~ updateNckJoystick();
    }
    
    fun void start() {
        updateWii();
        updateNck();
    }
}
