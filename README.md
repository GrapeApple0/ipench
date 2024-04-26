# iPench
Yet Another Network Benchmark Script

## What's this
Simple iperf benchmark script

## How to Run
```
curl -sL https://raw.githubusercontent.com/GrapeApple0/ipench/main/ipench.sh | bash
```
### Option
Choose region
Regions correspond to those on this list.
region africa/asia/europe/na(north america)/sa(south america)/oceania
Example: europe
```
curl -sL https://raw.githubusercontent.com/GrapeApple0/ipench/main/ipench.sh | bash -s -- -r europe
```
## Example Output
Provider: HostBrr
```
* ** ** ** ** ** ** ** ** ** ** ** ** ** *
*                 iPench                 *
*  Yet Another Network Benchmark Script  *
*                ver1.0.0                *
* ** ** ** ** ** ** ** ** ** ** ** ** ** *
#IPv4 Infomation
-----------------
ISP       : Michael Sebastian Schinzel trading as IP-Projects GmbH & Co. KG
AS        : AS48314
Org       : Ghostnet FRA
Country   : Germany
Location  : Frankfurt am Main, Hesse

#IPv4 mode
--------------------------
Provider        | Location(Port Speed)                | Send Speed      | Recv Speed      | Ping           
Hostkey         | Reykjavik, Iceland(10G)             | 1.03 Gbits/sec  | failed          | 51.22 ms       
TerraHost       | Sandefjord, Norway(10G)             | failed          | failed          | 27.7 ms        
Telia           | Stockholm, Sweden(10G)              | 2.58 Gbits/sec  | 2.44 Gbits/sec  | 27.2 ms        
Hiper           | Copenhagen, Denmark(10G)            | 5.32 Gbits/sec  | 3.46 Gbits/sec  | 16.54 ms       
Clouvider       | London, United Kingdom(10G)         | 1.13 Gbits/sec  | 3.69 Gbits/sec  | 15.56 ms       
Novoserve       | Amsterdam, Netherlands(40G)         | 7.07 Gbits/sec  | failed          | 8.794 ms       
Bouygues        | Paris, France(10G)                  | 5.76 Gbits/sec  | 5.77 Gbits/sec  | 10.54 ms       
SERVERD         | Paris, France(10G)                  | 2.86 Gbits/sec  | 3.91 Gbits/sec  | 15.16 ms       
Moji            | Paris, France(100G)                 | 6.35 Gbits/sec  | 4.68 Gbits/sec  | 17.3 ms        
Scaleway        | Vitry-sur-Seine, France(10G)        | 6.36 Gbits/sec  | 4.42 Gbits/sec  | 18.98 ms       
OVH             | Roubaix, France(10G)                | 8.90 Gbits/sec  | failed          | 13.3 ms        
OVH             | Strasbourg, France(10G)             | 5.70 Gbits/sec  | 887 Mbits/sec   | 17.12 ms       
Clouvider       | Frankfurt, Germany(10G)             | 7.83 Gbits/sec  | 5.09 Gbits/sec  | 7.822 ms       
Leaseweb        | Frankfurt, Germany(10G)             | 8.78 Gbits/sec  | 5.45 Gbits/sec  | 1.78 ms        
wilhelm.tel     | Frankfurt, Germany(40G)             | 1.06 Gbits/sec  | 3.73 Gbits/sec  | 11.84 ms       

#IPv6 Infomation
-----------------
ISP       : Michael Sebastian Schinzel trading as IP-Projects GmbH & Co. KG
AS        : AS48314
Org       : IP-Projects GmbH & Co.
Country   : Germany
Location  : Frankfurt am Main, Hesse

#IPv6 mode
--------------------------
Provider        | Location(Port Speed)                | Send Speed      | Recv Speed      | Ping           
TerraHost       | Sandefjord, Norway(10G)             | failed          | 1.35 Gbits/sec  | 25.76 ms       
Hiper           | Copenhagen, Denmark(10G)            | 4.80 Gbits/sec  | 6.16 Gbits/sec  | 11.42 ms       
Clouvider       | London, United Kingdom(10G)         | 877 Mbits/sec   | 4.98 Gbits/sec  | 14 ms          
Novoserve       | Amsterdam, Netherlands(40G)         | 8.29 Gbits/sec  | 6.06 Gbits/sec  | 7.38 ms        
Bouygues        | Paris, France(10G)                  | 6.21 Gbits/sec  | 7.62 Gbits/sec  | 10.05 ms       
SERVERD         | Paris, France(10G)                  | 2.42 Gbits/sec  | 6.77 Gbits/sec  | 13.22 ms       
Moji            | Paris, France(100G)                 | 7.37 Gbits/sec  | 5.33 Gbits/sec  | 17 ms          
Scaleway        | Vitry-sur-Seine, France(10G)        | 6.31 Gbits/sec  | 5.09 Gbits/sec  | 17.88 ms       
OVH             | Roubaix, France(10G)                | 9.12 Gbits/sec  | 7.12 Gbits/sec  | 10.38 ms       
OVH             | Strasbourg, France(1G)              | 6.50 Gbits/sec  | 783 Mbits/sec   | 3.624 ms       
Clouvider       | Frankfurt, Germany(10G)             | 8.28 Gbits/sec  | 7.88 Gbits/sec  | 1.118 ms       
Leaseweb        | Frankfurt, Germany(10G)             | 7.32 Gbits/sec  | 8.14 Gbits/sec  | 4.152 ms       
wilhelm.tel     | Frankfurt, Germany(40G)             | 2.11 Gbits/sec  | 3.62 Gbits/sec  | 7.556 ms
```
