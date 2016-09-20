if [[ -d /usr/local/bin ]] && [[ "$PATH" != *"/usr/local/bin:/usr/local/sbin"* ]]; then
	export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi
