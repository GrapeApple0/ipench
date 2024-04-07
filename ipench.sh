#!/bin/bash
PACKAGE_VERSION="1.0.0"
unset IPV4_ONLY IPV6_ONLY CUSTOM_SERVER
IPV4_ONLY="True"
IPV6_ONLY="True"
CUSTOM_SERVER="False"
while getopts '46:s:' flag; do
	case "${flag}" in
		4) IPV4_ONLY="True" && unset IPV6_ONLY ;;
		6) IPV6_ONLY="True" && unset IPV4_ONLY ;;
		s) CUSTOM_SERVER=${OPTARG} ;; 
		*) exit 1 ;;
	esac
done

function ip_info() {	
	declare -A countries=(
		["af"]="Afghanistan"
		["ax"]="Åland Islands"
		["al"]="Albania"
		["dz"]="Algeria"
		["as"]="American Samoa"
		["ad"]="Andorra"
		["ao"]="Angola"
		["ai"]="Anguilla"
		["aq"]="Antarctica"
		["ag"]="Antigua and Barbuda"
		["ar"]="Argentina"
		["am"]="Armenia"
		["aw"]="Aruba"
		["au"]="Australia"
		["at"]="Austria"
		["az"]="Azerbaijan"
		["bs"]="Bahamas"
		["bh"]="Bahrain"
		["bd"]="Bangladesh"
		["bb"]="Barbados"
		["by"]="Belarus"
		["be"]="Belgium"
		["bz"]="Belize"
		["bj"]="Benin"
		["bm"]="Bermuda"
		["bt"]="Bhutan"
		["bo"]="Bolivia"
		["ba"]="Bosnia and Herzegovina"
		["bw"]="Botswana"
		["bv"]="Bouvet Island"
		["br"]="Brazil"
		["io"]="British Indian Ocean Territory"
		["bn"]="Brunei"
		["bg"]="Bulgaria"
		["bf"]="Burkina Faso"
		["bi"]="Burundi"
		["kh"]="Cambodia"
		["cm"]="Cameroon"
		["ca"]="Canada "
		["cv"]="Cabo Verde"
		["ky"]="Cayman Islands"
		["cf"]="Central Africa"
		["td"]="Chad"
		["cl"]="Chile"
		["cn"]="China"
		["cx"]="Christmas Island"
		["cc"]="Cocos (Keeling) Islands"
		["co"]="Colombia"
		["km"]="Comoros"
		["cg"]="Republic of the Congo"
		["cd"]="Democratic Republic of the Congo"
		["ck"]="Cook Islands"
		["cr"]="Costa Rica"
		["ci"]="Cote d'Ivoire"
		["hr"]="Croatia"
		["cv"]="Cuba"
		["cy"]="Cyprus"
		["cz"]="Czech Republic"
		["dk"]="Denmark"
		["dj"]="Djibouti"
		["dm"]="Dominica"
		["do"]="Dominican Republic"
		["ec"]="Ecuador"
		["eg"]="Egypt"
		["sv"]="El Salvador"
		["gq"]="Equatorial Guinea"
		["er"]="Eritrea"
		["ee"]="Estonia"
		["et"]="Ethiopia"
		["fk"]="Falkland Islands"
		["fo"]="Faroe Islands"
		["fj"]="Fiji"
		["fi"]="Finland"
		["fr"]="France"
		["gf"]="French Guiana"
		["pf"]="French Polynesia"
		["tf"]="French Southern and Antractic Lands"
		["ga"]="Gabon"
		["gm"]="Gambia"
		["ge"]="Georgia"
		["de"]="Germany"
		["gh"]="Ghana"
		["gi"]="Gibraltar"
		["gr"]="Greece"
		["gl"]="Greenland"
		["gd"]="Grenada"
		["gp"]="Guadeloupe"
		["gu"]="Guam"
		["gt"]="Guatemala"
		["gg"]="Guernsey"
		["gn"]="Guinea"
		["gw"]="Guinea-Bissau"
		["gy"]="Guyana"
		["ht"]="Haiti"
		["hm"]="Heard and McDonald Islands"
		["va"]="Vatican"
		["hn"]="Honduras"
		["hk"]="Hong Kong"
		["hu"]="Hungary"
		["is"]="Iceland"
		["in"]="India"
		["id"]="Indonesia"
		["ir"]="Iran"
		["iq"]="Iraq"
		["ie"]="Ireland"
		["im"]="British Isles of Man"
		["il"]="Israel"
		["it"]="Italy"
		["jm"]="Jamaica"
		["jp"]="Japan"
		["je"]="Jersey"
		["jo"]="Jordan"
		["kz"]="Kazakhstan"
		["ke"]="Kenya"
		["ki"]="Kiribati"
		["kp"]="North Korea"
		["kr"]="South Korea"
		["kw"]="Kuwait"
		["kg"]="Kyrgyzstan"
		["la"]="Laos"
		["lv"]="Latvia"
		["l"]="Lebanon"
		["ls"]="Lesotho"
		["lr"]="Liberia"
		["ly"]="Libya"
		["li"]="Liechtenstein"
		["lt"]="Lithuania"
		["lu"]="Luxembourg"
		["mo"]="Macao"
		["mk"]="North Macedonia"
		["mg"]="Madagascar"
		["mw"]="Malawi"
		["my"]="Malaysia"
		["mv"]="Maldives"
		["ml"]="Mali"
		["mt"]="Malta"
		["mh"]="Marshall Islands"
		["mq"]="Martinique"
		["mr"]="Mauritania"
		["mu"]="Mauritius"
		["yt"]="Mayotte"
		["mx"]="Mexico"
		["fm"]="Micronesia (Federated States of)"
		["md"]="Moldova"
		["mc"]="Monaco"
		["mn"]="Mongolia"
		["me"]="Montenegro"
		["ms"]="Montserrat"
		["ma"]="Morocco"
		["mz"]="Mozambique"
		["mm"]="Myanmar"
		["na"]="Namibia"
		["nr"]="Nauru"
		["np"]="Nepal"
		["nl"]="Netherlands"
		["nc"]="New Caledonia"
		["nz"]="New Zealand"
		["ni"]="Nicaragua"
		["ne"]="Niger"
		["ng"]="Nigeria"
		["nu"]="Niue"
		["nf"]="Norfolk Island"
		["mp"]="Northern Mariana"
		["no"]="Norway"
		["om"]="Oman"
		["pk"]="Pakistan"
		["pw"]="Palau"
		["ps"]="Palestine"
		["pa"]="Panama"
		["pg"]="Papua New Guinea"
		["py"]="Paraguay"
		["pe"]="Peru"
		["ph"]="Philippines"
		["pn"]="Pitcairn"
		["pl"]="Poland"
		["pt"]="Portugal"
		["pr"]="Puerto Rico"
		["qa"]="Qatar"
		["re"]="Reunion"
		["ro"]="Romania"
		["ru"]="Russian Federation"
		["ru"]="Rwanda"
		["sh"]="St. Helena"
		["kn"]="St. Kitts and Nevis"
		["lc"]="St. Lucia"
		["om"]="St. Pierre and Miquelon"
		["vc"]="St. Vincent and the Grenadines"
		["ws"]="Samoa"
		["sm"]="San Marino"
		["st"]="Sao Tome and Principe"
		["sa"]="Saudi Arabia"
		["sn"]="Senegal"
		["rs"]="Serbia"
		["sc"]="Seychelles"
		["sl"]="Sierra Leone"
		["sg"]="Singapore"
		["sk"]="Slovakia"
		["si"]="Slovenia"
		["sb"]="Solomon Islands"
		["so"]="Somalia"
		["za"]="South Africa"
		["gs"]="South Georgia and South Sandwich Islands"
		["es"]="Spain"
		["lk"]="Sri Lanka"
		["sd"]="Sudan"
		["sr"]="Suriname"
		["sj"]="Svalbard and Jan Mayen Islands"
		["sz"]="Swaziland"
		["se"]="Sweden"
		["ch"]="Switzerland"
		["sy"]="Syria"
		["tw"]="Taiwan"
		["tj"]="Tajikistan"
		["tz"]="Tanzania"
		["th"]="Thailand"
		["tl"]="Timor-Leste"
		["tg"]="Togo"
		["tk"]="Tokelau"
		["to"]="Tonga"
		["tt"]="Trinidad and Tobago"
		["tn"]="Tunisia"
		["tr"]="Turkey"
		["tm"]="Turkmenistan"
		["tc"]="Turks and Caicos Islands"
		["tv"]="Tuvalu"
		["ug"]="Uganda"
		["ua"]="Ukraine"
		["ae"]="United Arab Emirates"
		["gb"]="United Kingdom"
		["us"]="United States"
		["um"]="U.S. Minor Outlying Islands"
		["uy"]="Uruguay"
		["uz"]="Uzbekistan"
		["vu"]="Vanuatu"
		["ve"]="Venezuela"
		["vn"]="Vietnam"
		["vg"]="British Virgin Islands"
		["vi"]="U.S. Virgin Islands"
		["wf"]="Wallis and Futuna"
		["eh"]="Western Sahara"
		["ye"]="Yemen"
		["zm"]="Zambia"
		["zw"]="Zimbabwe"
	)
	local IP_VERSION="$1"
	local MODE="${2:-none}"
	local READY
	if [[ "$IP_VERSION" == "4" ]]; then
		READY="$(ping -4 -c 1 -W 4 1.1.1.1 >/dev/null 2>&1 && echo true || ping -4 -c 1 -W 4 45.11.45.11 >/dev/null 2>&1 && echo true)"
		if ! $READY ; then
			return 1
		fi
	elif [[ "$IP_VERSION" == "6" ]]; then
		READY="$(ping -6 -c 1 -W 4 2606:4700:4700::1111 >/dev/null 2>&1 && echo true || ping -6 -c 1 -W 4 2a09:: >/dev/null 2>&1 && echo true)"
		if ! $READY ; then
			return 1
		fi
	fi
	local RESULT
	local ADDR
	local INFO
	local ISP
	local COUNTRY
	local REGION
	local CITY
	local AS
	local ORG
	RESULT="$(curl -sfL https://ip"$IP_VERSION"only.me/api/)"
	ADDR="$(echo "$RESULT" | awk -F "," '{print $2}')"
	INFO="$(curl -s ip-api.com/json/"$ADDR" | tr "{" '\n' | tr "," '\n' | tr "}" '\n' | sed 's/": "/":"/g' | sed 's/ /\\s/g')"
	ORG="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"org\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
	if [[ $MODE == "ipinfo" ]]; then
		IPINFO="$(curl -s https://ipinfo.io/"$ADDR" | tr "{" '\n' | tr "," '\n' | tr "}" '\n' | sed 's/": "/":"/g' | sed 's/ /\\s/g'))"
		ISP="$(echo -e "$IPINFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"org\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}' | sed 's/^AS[0-9]* //' )"
		AS="$(echo -e "$IPINFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"org\": | sed 's/"//g' | head -1 | awk -F ":" '{print $2}' | awk '{print $1}')"
		COUNTRY="${countries[$(echo -e "$IPINFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"country\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}' | awk '{print tolower($0)}')]}"
		CITY="$(echo -e "$IPINFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"city\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
		REGION="$(echo -e "$IPINFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"region\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
	else
		ISP="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"isp\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
		AS="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"as\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
		COUNTRY="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"country\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
		REGION="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"regionName\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
		CITY="$(echo -e "$INFO" | sed 's/\s/\n/g' | sed 's/\\s/ /g' | grep \"city\": | head -1 | awk -F ":" '{print $2}' | awk '{print substr($0, 2, length($0) - 2)}')"
	fi
	echo "#IPv$IP_VERSION Infomation"
	echo -----------------
	printf "%-10s: %s\n" "ISP" "$ISP"
	printf "%-10s: %s\n" "AS" "$AS"
	printf "%-10s: %s\n" "Org" "$ORG"
	printf "%-10s: %s\n" "Country" "$COUNTRY"
	printf "%-10s: %s\n" "Location" "$CITY, $REGION"
}

function run_iperf(){
	local SERVER="$1"
	local PORTS="$2"
	local PORT
	PORT=$(shuf -i "$PORTS" -n 1)
	local MODE="$3"
	local IP_VERSION="$4"
	local RECURSION="${5:-0}"
	if [[ "$RECURSION" -ge 1 ]]; then
		echo -en "\r\033[1K"
	fi
	if [[ "$RECURSION" -ge 3 ]]; then
		echo -n "Error: too many retries"
		sleep 2
		return 1
	fi
	if [[ "$MODE" == "s" ]]; then
		result=$(timeout 20 iperf3 -c "$SERVER" -p "$PORT" -P 8 2>&1 -"$IP_VERSION")
	elif [[ "$MODE" == "r" ]]; then
		result=$(timeout 20 iperf3 -c "$SERVER" -p "$PORT" -P 8 2>&1 -R -"$IP_VERSION")
	fi
	if [[ "$result" == *"error"* ]]; then
		if [[ "$result" == *"the server is busy running a test"* ]]; then
			echo -en "\r\033[0K"
			echo -n "$PROVIDER | $LOCATION: Port $PORT is busy, retrying"
			run_iperf "$SERVER" "$PORTS" "$MODE" "$IP_VERSION" $(("$RECURSION"+1))
		elif [[ "$result" == *"unable to connect to server"* ]]; then
			echo -en "\r\033[0K"
			echo -n "$PROVIDER | $LOCATION: Error: unable to connect to server"
			return 1
		fi
	elif [[ "$(echo "$result" | grep SUM | grep receiver | awk '{print $6 " " $7}')" == *"0.00 bits/sec"* ]]; then
		run_iperf "$SERVER" "$PORTS" "$MODE" "$IP_VERSION" $(("$RECURSION"+1))
	fi
}

function iperf_test() {
	local SERVER="$1"
	local PORTS="$2"
	local PROVIDER="$3"
	local LOCATION="$4"
	local IP_VERSION="$5"
	local SEND_SPEED
	local RECV_SPEED
	local LATENCY
	LATENCY="$(ping -c5 "$SERVER" 2>/dev/null | grep -o 'time=.*' | sed s/'time='//)"
	if [[ "$LATENCY" != "" ]]; then
		LATENCY="$(echo "$LATENCY" | awk '{sum+=$1} END {print sum/NR}')"
	else
		LATENCY="N/A"
	fi
	local MODES=(s r)
	for mode in "${MODES[@]}"; do
		local SPEED
		for ((j=1; 2>"$j"; j++)); do
			if [[ "$mode" == "s" ]]; then
				echo -n "Send testing $PROVIDER | $LOCATION with IPv$IP_VERSION #$j"
			elif [[ "$mode" == "r" ]]; then
				echo -n "Recv testing $PROVIDER | $LOCATION with IPv$IP_VERSION #$j"
			fi
			if ! run_iperf "$SERVER" "$PORTS" "$mode" "$IP_VERSION"; then
				sleep 2
			fi
			echo -en "\r\033[0K"
			if [[ "$result" == *"receiver"* ]]; then
				SPEED=$(echo "$result" | grep SUM | grep receiver | awk '{print $6 " " $7}')
			else
				SPEED=failed
			fi
		done
		if [[ "$mode" == "s" ]]; then
			SEND_SPEED="$SPEED"
		elif [[ "$mode" == "r" ]]; then
			RECV_SPEED="$SPEED"
		fi
	done
	printf "%-15s | %-35s | %-15s | %-15s | %-15s\n" "$PROVIDER" "$LOCATION" "$SEND_SPEED" "$RECV_SPEED" "$LATENCY ms"
}

function cleanup() {
	echo -en "\r\033[0K"
	echo "Cleaning up..."
	unset IPV4_ONLY IPV6_ONLY SERVERS CUSTOM_SERVER SERVERS_COUNT
	exit 0
}

SERVERS=(
	"speedtest.tyo11.jp.leaseweb.net" "5201-5210" "Leaseweb"  "Tokyo, Japan(10G)"               "Asia"          "v4|v6"
	"speedtest.uztelecom.uz"          "5200-5209" "Uztelecom" "Tashkent, Uzbekistan(10G)"       "Asia"          "v4|v6"
	"speedtest.sin1.sg.leaseweb.net"  "5201-5210" "Leaseweb"  "Singapore, Singapore(10G)"       "Asia"          "v4|v6"
	"speedtest.novoserve.com"         "5201-5206" "Novoserve" "Amsterdam, Netherlands(40G)"     "Europe"        "v4|v6"
	"lon.speedtest.clouvider.net"     "5200-5209" "Clouvider" "London, United Kingdom(10G)"     "Europe"        "v4|v6"
	"lg.terrahost.com"                "9200-9240" "TerraHost" "Sandefjord, Norway(10G)"         "Europe"        "v4|v6"
	"spd-icsrv.hostkey.com"           "5201-5210" "Hostkey"   "Reykjavik, Iceland(10G)"         "Europe"        "v4|v6"
	"paris.testdebit.info"            "9200-9240" "Bouygues"  "Paris, France(10G)"              "Europe"        "v4|v6"
	"iperf3.moji.fr"                  "5200-5240" "Moji"      "Ile-de-France, France(100G)"     "Europe"        "v4|v6"
	"la.speedtest.clouvider.net"      "5200-5209" "Clouvider" "Los Angeles, United States(10G)" "North America" "v4|v6"
	"speedtest.mia11.us.leaseweb.net" "5201-5210" "Leaseweb"  "Miami, United States(10G)"       "North America" "v4|v6"
	"speedtest.syd12.au.leaseweb.net" "5201-5210" "Leaseweb"  "Sydney, Australia(10G)"          "Oceania"       "v4|v6"
)
echo "* ** ** ** ** ** ** ** ** ** ** ** ** ** *"
echo "*                 iPench                 *"
echo "*  Yet Another Network Benchmark Script  *"
echo "*                ver$PACKAGE_VERSION                 *"
echo "* ** ** ** ** ** ** ** ** ** ** ** ** ** *"
trap cleanup INT
if [[ "$CUSTOM_SERVER" != "False" ]]; then
	# TODO
	exit 0
else
	SERVERS_COUNT=${#SERVERS[*]}
	SERVERS_COUNT=$(("$SERVERS_COUNT" / 6))
	if [[ "$IPV4_ONLY" == "True" ]]; then
		ip_info 4 ipinfo
		echo
		echo "#IPv4 mode"
		echo --------------------------
		printf "%-15s | %-35s | %-15s | %-15s | %-15s\n" "Provider" "Location(Port Speed)" "Send Speed" "Recv Speed" "Ping"
		for ((i=0; "$SERVERS_COUNT">"$i"; i++)); do
			iperf_test "${SERVERS[$i*6]}" "${SERVERS[$i*6+1]}" "${SERVERS[$i*6+2]}" "${SERVERS[$i*6+3]}" 4
		done
	fi
	if [[ "$IPV6_ONLY" == "True" ]]; then
		ip_info 6 ipinfo
		echo
		echo "#IPv6 mode"
		echo --------------------------
		printf "%-15s | %-35s | %-15s | %-15s | %-15s\n" "Provider" "Location(Port Speed)" "Send Speed" "Recv Speed" "Ping"
		for ((i=0; "$SERVERS_COUNT">"$i"; i++)); do
			iperf_test "${SERVERS[$i*6]}" "${SERVERS[$i*6+1]}" "${SERVERS[$i*6+2]}" "${SERVERS[$i*6+3]}" 6
		done
	fi
fi
