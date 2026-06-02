#!/bin/bash
set -euo pipefail

systemctl list-units --type=service --state=running --no-legend | awk '{print $1}'