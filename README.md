
#Pets Shelter Terra - Platform

## Table of Contents

- [Description](#description)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)

## Description

This project, **Pets Shelter Terra - Platform**, is a comprehensive platform aimed at managing a pet shelter. It includes functionalities to handle pets' data, client information, medical history, blogs, and user management.

## Project Structure

```bash
.
├── api
│   ├── __init__.py
│   └── v1
│       ├── core.py
│       └── __init__.py
├── api.py
├── dump-v1.8.3.sql
├── initdb.sql
├── models
│   ├── blog.py
│   ├── client.py
│   ├── db.py
│   ├── food.py
│   ├── __init__.py
│   ├── medical_history.py
│   ├── pet.py
│   ├── shelter.py
│   └── user.py
├── project_structure.txt
├── public
│   ├── blocks
│   │   ├── login-box.html
│   │   ├── medical_history.html
│   │   ├── pets_cards_filter.html
│   │   ├── register-box.html
│   │   ├── side-navbar.html
│   │   └── top-navbar.html
│   ├── blog.html
│   ├── blogs.html
│   ├── dashboard.html
│   ├── donate.html
│   ├── home.html
│   ├── login.html
│   ├── medical.html
│   ├── pet.html
│   ├── pets.html
│   ├── profile.html
│   ├── register.html
│   └── shelter.html
├── README.md
├── run.py
└── static
    ├── assets
    │   └── favicon.ico
    ├── css
    │   ├── dark-mode.css
    │   └── styles.css
    └── js
        ├── bootstrap.bundle.min.js
        ├── jquery-3.6.0.min.js
        ├── medical.js
        ├── payment.js
        ├── pets.js
        └── scripts.js
```

10 directories, 45 files

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/YassineRKB/pstp.git

2. Navigate to the project directory:

    cd pstp

3. Install dependencies:

    pip install flask sqlalchemy Flask-SQLAlchemy


    Set up the database by executing the SQL script:

        mysql -u your_username -p < initdb.sql
    
    (optional) fill db with available db dump
        
        cat dump-vX.X.X.sql | mysql -u your_user -p

## Usage

    #Run the application:

        DB_USER="dev_usr" DB_PASSWORD="dev_pwd" DB_NAME="db_dev" python3 run.py
        DB_USER="dev_usr" DB_PASSWORD="dev_pwd" DB_NAME="db_dev" python3 api.py

    #Access the application by visiting http://localhost:5000 in your web browser.
    #Dashboard via http://localhost:5000/dashboard
    #Profile via http://localhost:5000/profile
    #Login as admin via http://localhost:5000/login
        user:admin@pstp.ga
        pass:12345678
    #Login as client via http://localhost:5000/login
        user:client@pstp.ga
        pass:12345678
    #Login as worker via http://localhost:5000/login
        user:worker@pstp.ga
        pass:12345678
    
    api lives in http://localhost/:5001/api/v1

## credits
    yassine rakibi <yassine@arcraven.com>

## license
    gpl 3.0
