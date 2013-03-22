#! /bin/tcsh -f

if ($1 == "") then
    echo "Usage: $0 eamserver:port"
    exit
endif

set hostport = $1

if ($1 == "cta") then
    set hostport = "172.0.0.76:7878"
endif

set url = "http://$hostport/axis/services/EWSConnector"

echo 

while 1
    echo --------------------------------------------------
    date
    echo "Running: curl $url"
    curl "$url"
end
