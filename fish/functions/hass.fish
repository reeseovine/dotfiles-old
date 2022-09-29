function hass -d "home assistant cli"
	bash -c ". \$HOME/.secrets/homeassistant && hass-cli $argv"
end
