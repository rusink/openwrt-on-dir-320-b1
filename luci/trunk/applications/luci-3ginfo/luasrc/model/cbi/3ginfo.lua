--[[

LuCI p910nd
(c) 2008 Yanira <forum-2008@email.de>
(c) 2012 Jo-Philipp Wich <jow@openwrt.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

]]--

local uci = luci.model.uci.cursor_state()
local net = require "luci.model.network"
local m, dev, pin, port, qos, lang
local try_devices = nixio.fs.glob("/dev/ttyUSB*") or nixio.fs.glob("/dev/ttyACM*") or nixio.fs.glob("/dev/cdc*")

m = Map("3ginfo", translate("3ginfo - information about 3g/4g connection"),
        translatef("First you have to install the packages to get support for 3g/4g modems."))

net = net.init(m.uci)

dev = m:section(Value, "device", translate("Device"))
dev:value("", "")
if try_devices then
	local node
	for node in try_devices do
		dev:value(node)
	end
end
dev.default = ""

pin = m:section(Value, "pincode", translate("PIN code (only for 3g), optional")
pin.default = ""

port = m:section(Value, "http_port", translate("Port for HTTP connections"))
port.default = "81"

qos = m:section(Flag, "qos", translate("Enable QOS support"))
qos.enabled = "1"
qos.disabled = "0"

lang = m:section(Value, "language", translate("Language"))
lang:value("ru", "Russian")
lang:value("en", "English")
lang.default = "ru"
 
return m
