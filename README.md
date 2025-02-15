# JSP Project Import Guide

## Prerequisites
- **Eclipse IDE for Enterprise Java Developers** (Download from [Eclipse](https://www.eclipse.org/downloads/))
- **Apache Tomcat** (Download from [Tomcat](https://tomcat.apache.org/download-90.cgi))
- **Java Development Kit (JDK)** installed and configured

## Steps to Import JSP Project into Eclipse

### Step 1: Install Java EE Version of Eclipse
Ensure you have **Eclipse IDE for Enterprise Java Developers**, as it includes JSP and Servlet support.

### Step 2: Install Apache Tomcat
1. Download **Apache Tomcat** from the official site.
2. Extract the downloaded folder.
3. Open **Eclipse** → **Window** → **Preferences** → **Server** → **Runtime Environments**.
4. Click **Add**, select **Apache Tomcat**, and specify the extracted folder location.

### Step 3: Import the JSP Project
1. Open **Eclipse** → **File** → **Import**.
2. Select **Existing Projects into Workspace** under **General**.
3. Click **Next**.
4. Browse and select your **JSP project folder**.
5. Click **Finish**.

### Step 4: Configure the Project with Tomcat
1. Right-click on the project → **Properties**.
2. Go to **Targeted Runtimes** and check **Apache Tomcat**.
3. Click **Apply and Close**.

### Step 5: Run the Project
1. Right-click the project → **Run As** → **Run on Server**.
2. Select **Tomcat Server** and click **Finish**.
3. Open a browser and visit: `http://localhost:8080/service_center/`

Your JSP project should now be running successfully!

## Troubleshooting
- Ensure **Tomcat Server** is properly configured in **Eclipse**.
- Check the **Java Build Path** to confirm dependencies.
- Review the **server logs** for any errors.
