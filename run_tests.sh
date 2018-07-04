#!/bin/bash

GUESTOS="Debian.9.4.0.aarch64"
ARCH="aarch64"
BOOTSTRAP_FLAGS="--yes-to-all"
QEMU="qemu-system-aarch64"
VARIANTS_CONF="test-qemu-variants.cfg"

usage() {
	U=""
	if [[ -n "$1" ]]; then
		U="${U}$1\n\n"
	fi
	U="${U}Usage: $0 [options]\n\n"
	U="${U}Options:\n"
	U="$U    --guestos:             Choose guest list (default Debian.9.4.0.aarch64)\n"
	U="$U    --arch:                Guest arch list (default aarch64)\n"
	U="$U    --flags:               Avocado vt-bootstrap options (default --yes-to-all)\n"
	U="$U    --qemu:               	Qemu binary path (default qemu-system-aarch64)\n"
	U="$U    -h | --help:           Show this output\n"
	U="${U}\n"
	echo -e "$U" >&2
}

while :
do
	case "$1" in
	  --arch)
		ARCH="$2"
		shift 2
		;;
	  --guestos)
		GUESTOS="$2"
		shift 2
		;;
	  --flags)
		BOOTSTRAP_FLAGS="$2"
		shift 2
		;;
	  --qemu)
		QEMU="$2"
		shift 2
		;;
	  -h | --help)
		usage ""
		exit 1
		;;
	  --) # End of all options
		shift
		break
		;;
	  -*) # Unknown option
		echo "Error: Unknown option: $1" >&2
		exit 1
		;;
	  *)
		break
		;;
	esac
done

# Avocado Virt Test init
export PATH=$HOME/.local/bin:$PATH

IFS=',' read -ra GUESTS <<< "$GUESTOS"
for i in "${GUESTS[@]}"; do
    avocado vt-bootstrap --vt-type qemu --vt-guest-os $i $BOOTSTRAP_FLAGS
done

DATA_DIR=/var/lib/avocado/data

if [[ -d "$HOME/avocado/data" ]]; then
    echo "No-Root User"
    DATA_DIR=$HOME/avocado/data
fi

echo 'Avocado Data Directory: '$DATA_DIR

CONFIG_DIR=$DATA_DIR/avocado-vt/backends/qemu/cfg

# Copy Avocado-VT config file
if [[ -w "$CONFIG_DIR" ]]; then
    cp $VARIANTS_CONF $CONFIG_DIR
else
    sudo cp $VARIANTS_CONF $CONFIG_DIR
fi
    
# Add exstra variables and filters
cd $CONFIG_DIR
echo "qemu_binary = $QEMU" >> $VARIANTS_CONF
echo "only $GUESTOS" >> $VARIANTS_CONF

# Run Tests with variants.cfg
avocado run --vt-config $VARIANTS_CONF
