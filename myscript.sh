#!/bin/bash
set -e
aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id cvpn-endpoint-0194fcb23654d7e44 --output json