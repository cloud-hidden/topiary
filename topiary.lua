--topiary 

--input 1: quantized cv
--input 2: gate
--output 1: cv
--output 2: gate

function init()
	input[1].mode('stream')
	input[2].mode('change',1,0.1,'rising')
	output[2].action = pulse()
	previous = nil
	quantd_sample = nil
end

input[2].change = function()
	quantd_sample = quantsemitones(input[1].volts)
	note_number = findnotenumber(quantd_sample)
	
	if note_number == previous then --print("8< "..note_number.." "..quantd_sample) 
	else
		--print(note_number.." "..quantd_sample)
		output[1].volts = quantd_sample
		output[2]()
		previous = note_number
	end
end

function quantsemitones(inputvolts)
	return math.floor(inputvolts/(1/12)+0.5)*1/12
end

function findnotenumber(quantizedvolts)
	return math.floor(quantizedvolts*12+0.5)%12
end