# Appointments ETL Project

**Project Description:**  
This project is designed as an ETL (Extract, Transform, Load) pipeline to process the "No Show Appointments" dataset from Kaggle. The project automates the process of extracting raw data, cleaning it, transforming it using SQL, and loading it into a MySQL database. This project could be useful for data engineers looking to optimize data analytics workflows and automate the ETL process.

**Dataset Source:**
The dataset used in this project is the "No Show Appointments" dataset from Kaggle. You can find the dataset here. https://www.kaggle.com/datasets/joniarroba/noshowappointments

**Problem Statement:**  
Datasets often require significant cleaning and transformation to be useful for analysis. This project addresses the following issues encountered when working with raw datasets:

- **Data Cleaning:** The dataset from Kaggle often contains missing values, incorrect formats, and erroneous records. This project cleans such data.
- **Data Transformation:** Raw data may not be in a suitable format for analysis. SQL queries are used to transform the data into a more usable format.
- **Data Loading:** It is crucial to load the data into a database correctly. This project automatically uploads the cleaned and transformed data into a MySQL database.
- **Efficiency in Time and Resources:** Automating the ETL process eliminates the need for manual data handling, saving both time and resources.

## Technologies Used

- **Python 3.10**: Used for data processing and ETL operations.
- **MySQL**: Used as the database for storing the processed data.
- **Docker & Docker Compose**: The project is containerized using Docker and Docker Compose to manage dependencies and environment setup.
- **Kaggle API**: Used to download the dataset directly from Kaggle.
- **SQL**: Used for data transformation and analysis.

## How to Run the Project

### Prerequisites

- Make sure Docker and Docker Compose are installed.  
  **To install Docker**: [Docker Docs](https://docs.docker.com/get-docker/)
  
### Setup

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/ByteQuanta/appointments-etl.git
    cd appointments-etl
    ```

2. **Set Up Environment Variables**:
    Create a `.env` file and add the following environment variables:
    ```
    DB_USER=<your-database-username>
    DB_PASS=<your-database-password>
    DB_HOST=mysql
    DB_PORT=3306
    DB_NAME=appointments_project_db
    ```

3. **Start Docker Containers**:
    Run the following command to start the Docker containers:
    ```bash
    docker-compose up --build
    ```

    This will:
    - Start the **MySQL database container**.
    - Start the **Python application container**.

    The application will initialize the database and start the ETL process.

### ETL Process

1. **Data Download:** The dataset is downloaded using the Kaggle API.
2. **Data Cleaning:** Raw data is cleaned by removing missing values and fixing any errors.
3. **Data Loading:** The cleaned data is uploaded into a MySQL database.
4. **Data Transformation:** SQL queries are applied to transform the data into a usable format.
5. **Testing:** Test SQL queries are run to validate the accuracy of the data.

### User Information

- Once the ETL process is complete, the application will output information about the status and results of the operations to the console.

## Project Structure

- **`etl/etl.py`**: Python script that performs the ETL operations.
- **`etl/02_transform.sql`**: SQL queries used to transform the data.
- **`etl/03_tests.sql`**: SQL queries used for testing the data integrity.
- **`docker-compose.yml`**: Docker Compose configuration file.
- **`Dockerfile`**: The Dockerfile that sets up the Python environment and dependencies.
- **`requirements.txt`**: List of Python dependencies required for the project.

## Problems Solved

This project addresses the following problems:

- **Data Cleaning:** The raw dataset from Kaggle often contains missing and erroneous data, which is cleaned before use.
- **Data Transformation:** SQL queries are used to transform raw data into a format suitable for analysis.
- **Data Loading:** The project automates the process of uploading cleaned and transformed data into a MySQL database.
- **Data Validation:** SQL test queries ensure that the loaded data is accurate and reliable.

---

This English version of the `README.md` file should be ready to go for your GitHub repository. Feel free to modify any sections further if you wish to add or adjust any details.
