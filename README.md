# Configure Starlink for IPv6

### Requirements

* Hardware: Ubiquiti EdgeRouter X
* Must *not* be using the Starlink Router
  * Connect the Starlink power brick directly to the WAN port (ie. `eth0`) on your EdgeRouter X

### Usage

* Copy the script under `/config/scripts` to the same directory on the device
* Copy the `enable-starlink-ipv6.sh` script to your home directory (ie. `/home/ubnt`)
* Execute the script

### Verification

Run the following command:

```
show interfaces
```

Look for the `switch0` interface, and make sure there's an IPv6 `/64` prefix associated with it.

* **IMPORTANT**: If you're on Windows, make sure that IPv6 protocol is enabled on your network interface.
