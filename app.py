from flask import *
from flask_mail import *
import random
from APIs import EnterForms
from APIs.EnterpriseAPI import *
from views import profile
from views import users
from views import logistics

app = Flask(__name__)
sk = str(random.randint(1, 101))
app.secret_key = sk

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods = ['GET', 'POST'])
def login():
    form = EnterForms.LoginForm(request.form)
    if request.method == 'POST':
        if request.form['submit'] == 'Login' and form.validate():
            username = request.form['usrname']
            passwd = request.form['passwd']
            logger = Logger(username, passwd)
            if logger == True:
                session['username'] = username
                session['password'] = passwd
                return redirect(url_for('home'))
            elif logger == False:
                flash('LOGIN ERROR: Bad username or password', category = 'fail')
                return render_template('login.html', form = form)

    return render_template('login.html', form = form)

@app.route('/logout')
def logout():
    session.pop('username', None)
    session.pop('password', None)
    return redirect(url_for('login'))

@app.route('/home')
def home():
    return render_template('home.html', username = session['username'] )


# ........ JSON returning urls.
@app.route('/GrabItems')
def GrabItems():
    code = request.args['ItCode']
    try:
        item = ItemAdder(code)
        for i in item:
            return jsonify(msg = 'success', itemcode = i[0], itemname = i[1], itemunit = i[2])
    except Exception as e:
        return jsonify(msg = str(e))

@app.route('/GrabBin')
def GrabBin():
    code = request.args['BCode']
    try:
        bn = BinInfo(code)
        return jsonify(msg = 'success', BinCode = bn[0], BinName = bn[1], BinStatus = bn[3], BinDesc = bn[2])
    except Exception as e:
        return jsonify(msg = str(2))

#@app.route('/testing', methods = ['GET','POST'])
#def testing():

#    if request.method == 'POST':
#        field = request.form.getlist('fuckit')
#        return str(field)
#    return render_template('tester.html')

app.register_blueprint(profile.mod)
app.register_blueprint(users.mod)
app.register_blueprint(logistics.mod)

#if __name__ == '__main__':
#    app.run(debug = True)
