from flask import Flask, render_template, request, send_file
import loanalgo

app = Flask(__name__)

# homepage, directs to borrower -> create loan, lender -> view loans
@app.route('/', methods=['GET', 'POST'])
def index():
	return render_template('index.html')

# can be used only by the borrower
@app.route('/createLoan', methods=['GET', 'POST'])
def createLoan():
	return render_template('createLoan.html')

# can be viewed by both lender and borrower
@app.route('/viewLoans', methods=['GET', 'POST'])
def viewLoans():
	return render_template('viewLoans.html')

# can be used only by lender
@app.route('/bidToLoan', methods=['GET', 'POST'])
def bidToLoan():
	return render_template('loanBid.html')

# just a post request, handled from client side JS
@app.route('/getBidWinner', methods=['GET', 'POST'])
def getBidWinner(bidsAmountArray):
	return loanalgo.getCentralTendency(bidsAmountArray)

# can be used only by the lender
@app.route('/payToLoan', methods=['GET', 'POST'])
def payToLoan():
	return render_template('loanPay.html')

# can be used only by the borrower
@app.route('/repayLoan', methods=['GET', 'POST'])
def repayLoan():
	return render_template('loanRepay.html')

# both lender and borrower can view the results
@app.route('/displayResults', methods=['GET', 'POST'])
def displayResults():
	return render_template('results.html')

if __name__ == '__main__':
	app.run(debug=True)