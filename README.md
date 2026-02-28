# DATA.DB.300 Project

Contributor: Veeti Salminen, 150405063

## Business domain description

Business domain of this project is the management of emergency services resources. This includes entities of units (Ambulance, Fire Engine), different types of employees and missions that the resources are responding to. Database can be used to record employee work times and their assignment to a specific unit. Units can have different states and can be assigned to missions.

The system can be used internationally to manage resources worldwide, but as the domain is physically dependent it would be the best to have the system divided into country specific units. System is write heavy as each new mission and status update cause a write operation.

If the system was in use in Finland, the peak number of concurrent users would be most likely when employees are clocking in at the same time when their shifts begin. There would be thousands of concurrent users. In europe scale the peak user count could be tens of thousands of users.


## Implementation

The initial DBMS was chosen to be PostgreSQL. Table schemas and indexes are created in `tables.sql`, insert statements for example data are in `data.sql`.

Below are the 10 use-cases that are implemented in `operations.sql`. 


1. Get current employees on a unit

2. Create a new mission with units

3. Start shift on an employee on unit

4. End shift on an employee on unit

5. Get status of all units assigned to a mission

6. Change mission code

7. Add a unit to an existing mission

8. Get all 1st level subordinates of an employee

9. Get employees of a given unit at the time of a given mission

10. Set mission as completed and set all unit's status as available


## Expanded Domain

The second DBMS is MongoDB, where employee work history and more detailed unit status functionality was implemented. Document insertions and queries are in `mongo.sh`. Following are the 3 new use cases implemented.

1. Get work history report of an employee

2. Get status history of a unit on a mission

3. Change employee's position

## Complex use-cases

Most complex out of the use cases are 9 and 10 from the original and 3 from the additional use-cases.

## Database Distribution

Assuming worldwide usage of the system, each country would have their own tables. Each country would be serviced by the closest data center available. Data would be replicated locally in the data center and in the second closest data center.

20 nodes would be distributed along the data centers equally with 4 in each center. This system would be resilient to full failure of one data center without disruption to any operation as the traffic can be channelled to a next center.

## CLI app

In `app.py` there is a simple CLI application that provides some simple operations to the database. There was some issue with implementing funcitonality to create a new mission as the HSTORE creation did not work. I removed this option, but there is still other interaction. 

The app is very simple and executing the queries is pretty simple and there were no data challenges. If the app was developed further and the MongoDB database would be taken into use also, I would imagine that the interaction would be more complex. Also now there is some overlap between the information in the PostgreSQL and MongoDB databases, so if the position of an employee is changed, it needs to be changed in both systems. The overall system would have different roles to interact with the database, so each individual operation role would not necessarily be complex. For example, the interface for an employee to clock in/out would be very simple to implement. In contrast, a HR system that would manage the employee hours and positions would need more complex logic and queries. 


## AI usage

When writing the SQL queries, VS Code's IntelliSense code completion was used. This sometimes provided accurate predicitons of the queries, but sometimes the intention was incorrect or otherwise invalid so editing was needed. Code completion was also used with the MongoDB queries. Code completion was somewhat usefu with the sample data generation, but it had to be edited to match the original intention and to create situations needed in some use-cases. ChatGPT and code completion was used to debug and finalize the CLI app. The base structure of the CLI app was done manually.