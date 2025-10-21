import Bluetooth from "gi://AstalBluetooth"
import { timeout } from "ags/time"
import { execAsync } from 'ags/process';
import GObject from "gi://GObject";

export default class BluetoothController {
    private bt: Bluetooth.Bluetooth;
    private adapter: Bluetooth.Adapter | null;

    public constructor(){
        this.bt = Bluetooth.get_default()
        this.adapter = this.bt.get_adapter()
    }

    public getDiscoveredDevices(): Bluetooth.Device[]{
        const devices: Bluetooth.Device[] = []
        for(const device of this.bt.get_devices()){
            if(!device.get_paired() && device.name){
                devices.push(device)
            }
        }

        return devices;
    }

    public getPairedDevices(): Bluetooth.Device[]{
        const devicesDisconnected: Bluetooth.Device[] = []
        const devicesConnected: Bluetooth.Device[] = []
        for(const device of this.bt.get_devices()){
            if(device.get_paired()){
                if(device.get_connected()){
                    devicesConnected.push(device)
                }
                else{
                    devicesDisconnected.push(device)
                }
            }
        }
        return devicesConnected.concat(devicesDisconnected);
    }

    public getConnectedDevices(): Bluetooth.Device[]{
        const devices: Bluetooth.Device[] = []
        for(const device of this.bt.get_devices()){
            if(device.get_paired() && device.get_connected()){
                devices.push(device)
            }
        }
        return devices;
    }

    public discoverNewDevices(refreshDiscoveredDevices: (() => void)) {
        try {
            if(this.adapter?.discovering){
                return this.adapter?.stop_discovery()
            }

            this.adapter?.start_discovery();

            const discoveryTimeout = 5000
            timeout(discoveryTimeout, () => {
                if(this.adapter?.discovering){
                    this.adapter.stop_discovery()
                }
                refreshDiscoveredDevices()
            })
        } 
        catch (err) {
            print(`Failed to start discovery: ${err}`);
        }
    }

    public async pairDevice(device: Bluetooth.Device): Promise<boolean>{
        try {
            const address = device.address;
            // Pair the device
            const scriptPath = `/home/dylan/Projects/hyprtaskbarWindows/widget/Utilities/Bluetooth/test.sh`;
            await execAsync(['bash', scriptPath, address]);
            return true;
        } catch (err) {
            logError(err);
            return false;
        }
    }
}