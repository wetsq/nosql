db.employees.insertMany([
  {
    _id: 1,
    name: "John Smith",
    position: "Firefighter",
    supervisor_id: null,
    position_history: [
      {
        position: "Firefighter",
        start_date: ISODate("2020-01-01")
      }
    ]
  },
  {
    _id: 2,
    name: "Jane Doe",
    position: "Paramedic",
    supervisor_id: 1,
    position_history: [
      {
        position: "Paramedic",
        start_date: ISODate("2021-01-01")
      },
      {
        position: "Student Paramedic",
        start_date: ISODate("2019-01-01")
      }
    ]
  },
  {
    _id: 3,
    name: "Bob Johnson",
    position: "Senior Firefighter",
    supervisor_id: 1,
    position_history: [
      {
        position: "Senior Firefighter",
        start_date: ISODate("2019-01-01")
      },
      {
        position: "Firefighter",
        start_date: ISODate("2018-01-01")
      }
    ]
  }
])

db.missions.insertMany([
  {
    _id: 1,
    code: "402B",
    description: "Structure fire at 123 Main St.",
    status: "Completed",
    created_at: ISODate("2020-01-01T12:00:00Z"),
    units: [
      {
        name: "Engine 1",
        status: "Available",
        status_history: [
          {
            status: "Available",
            timestamp: ISODate("2020-01-01T13:02:00Z")
          },
          {
            status: "On Scene",
            timestamp: ISODate("2020-01-01T12:07:30Z")
          },
          {
            status: "On Route",
            timestamp: ISODate("2020-01-01T12:00:30Z")
          },
          {
            status: "Alerted",
            timestamp: ISODate("2020-01-01T12:00:00Z")
          }
        ]
      },
      {
        name: "Engine 2",
        status: "Available",
        status_history: [
          {
            status: "Available",
            timestamp: ISODate("2020-01-01T13:02:00Z")
          },
          {
            status: "On Scene",
            timestamp: ISODate("2020-01-01T12:12:15Z")
          },
          {
            status: "On Route",
            timestamp: ISODate("2020-01-01T12:00:20Z")
          },
          {
            status: "Alerted",
            timestamp: ISODate("2020-01-01T12:00:00Z")
          }
        ]
      }
    ]
  }
])

# 1. Get a work history report of an employee

db.employees.findOne(
  { _id: 2 },
  { name: 1, position_history: 1, _id: 0 }
)

# 2. Get status history of a unit on a mission

db.missions.findOne(
  { _id: 1, "units.name": "Engine 1" },
  { "units.status_history": 1, _id: 0 }
)

# 3. Add Change employee's position

db.employees.updateOne(
  { _id: 2 },
  {
    $set: { position: "Paramedic" },
    $push: {
      position_history: {
        position: "Paramedic",
        start_date: new Date()
      }
    }
  }
)