local tArgs = {...}
local channel = 3
local masterChannel = 1
local modem

function init()
{
	modem = peripheral.wrap("right")
	modem.open(channel)
}

function listenForOrder()
{
	local event, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
	
	takeFromAbove(message)
}

function takeFromAbove(amount)
{
	local success = true
	for i=1,amount do
		if turtle.suckUp() == false then
			success = false
		end
	end
	if success == false then
		for i=1,amount do
			turtle.dropUp()
		end
	end

	if success == false then
		requestMoreItems()
	end
}

function requestMoreItems()
{
	modem.transmit(channel, masterChannel, "produce "..channel)
}

init()
while true do
	listenForOrder()
end
