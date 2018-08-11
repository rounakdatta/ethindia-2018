import math

def getCentralTendency(array_original):
	array = sorted(array_original)
	
	while(len(array) > 1):
		# print(array)
		fMean = (array[0] + array[-1]) / 2
		array = array[1:-1]
		array.append(fMean)
		array = sorted(array)

	winning_bid = min(array_original, key=lambda x:abs(x - array[0]))
	return array_original.index(winning_bid)

def simpleInterest(p, t, r):
	return (p * t* r) / 100

def getMyInterest(myDeposit, totalDeposit, fixedPc=2): # fixedPc will be fraction (between 0 to 1)
	remMoney = totalDeposit - (fixedPc * totalDeposit)
	myIncentive = math.exp((myDeposit - remMoney) / myDeposit)
	return myIncentive