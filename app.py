from flask import Flask, render_template, request, send_file
import loanalgo

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
	return render_template('index.html')

@app.route('/viewLoans', methods=['GET', 'POST'])
def viewLoans():
	return render_template('viewLoans.html')

@app.route('/bidToLoan', methods=['GET', 'POST'])
def bidToLoan():
	return render_template('loanBid.html')

@app.route('/getBidWinner', methods=['GET', 'POST'])
def getBidWinner(bidsAmountArray):
	return loanalgo.getCentralTendency(bidsAmountArray)

@app.route('/payToLoan', methods=['GET', 'POST'])
def payToLoan():
	return render_template('loanPay.html')

@app.route('/repayLoan', methods=['GET', 'POST'])
def repayLoan():
	return render_template('loanRepay.html')

@app.route('/displayResults', methods=['GET', 'POST'])
def displayResults():
	return render_template('results.html')

if __name__ == '__main__':
	app.run(debug=True)