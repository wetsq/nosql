import psycopg
from psycopg.rows import dict_row

DB_CONFIG = {
    "host": "localhost",
    "dbname": "labdb",
    "user": "student",
    "password": "student",
}


def main():
    print("Connecting to the database...")

    try:
        with psycopg.connect(**DB_CONFIG, row_factory=dict_row) as conn:
            print("Connected successfully!")

            while True:
                print("\nPlease select an operation:")
                print("1. Assign a unit to a mission")
                print("2. Get mission information")
                print("3. Get status of all units assigned to a mission")
                print("4. Exit")

                choice = input("Enter your choice (1-4): ")

                if choice == '1':
                    mission_id = int(input("Enter mission ID: "))
                    unit_name = input("Enter unit name: ").strip()

                    with conn.cursor() as cur:
                        cur.execute("""
                            UPDATE missions
                            SET units = array_append(units, %s)
                            WHERE id = %s;
                        """, (unit_name, mission_id))

                        conn.commit()

                    print("Unit assigned successfully.")

                elif choice == '2':
                    mission_id = int(input("Enter mission ID: "))

                    with conn.cursor() as cur:
                        cur.execute("""
                            SELECT id, code, description, status, address, location, units
                            FROM missions
                            WHERE id = %s;
                        """, (mission_id,))

                        result = cur.fetchone()

                    if result:
                        print("\nMission Information")
                        print("-------------------")
                        print(f"Mission ID: {result['id']}")
                        print(f"Code: {result['code']}")
                        print(f"Description: {result['description']}")
                        print(f"Status: {result['status']}")
                        print(f"Address: {result['address']}")
                        print(f"Location: {result['location']}")
                        print(f"Units: {result['units']}")
                    else:
                        print("Mission not found.")

                elif choice == '3':
                    mission_id = int(input("Enter mission ID: "))

                    with conn.cursor() as cur:
                        cur.execute("""
                            SELECT u.name, u.status
                            FROM units u
                            JOIN missions m ON u.name = ANY(m.units)
                            WHERE m.id = %s;
                        """, (mission_id,))

                        results = cur.fetchall()

                    if results:
                        print("\nUnits assigned to mission:")
                        for row in results:
                            print(f"{row['name']} - {row['status']}")
                    else:
                        print("No units found for this mission.")

                elif choice == '4':
                    print("Exiting application.")
                    break

                else:
                    print("Invalid choice. Try again.")

    except Exception as e:
        print(f"Database error: {e}")


if __name__ == "__main__":
    main()