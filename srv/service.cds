using {airline.db as db} from '../db/schema';

service catalogService {
    entity Flights    as
        projection on db.Flights {
            ID,
            flightNumber,
            airlineName,
            departureTime,
            arrivalTime,
            ticketPrice,
            availableSeats,
            status,
            sourceAirport,
            destinationAirport
        }

    entity Bookings   as
        projection on db.Bookings {
            ID,
            bookingNumber,
            seatNumber,
            bookingStatus,
            amountPaid,
            flight,
            bookingItems
        }

    entity Passengers as
        projection on db.Passengers {
            ID,
            firstName,
            lastName,
            email,
            nationality
        };
}

service AdminService {
    entity Airports     as projection on db.Airports;
    entity Flights      as projection on db.Flights;
    entity Passengers   as projection on db.Passengers;
    entity Bookings     as projection on db.Bookings;
    entity BookingItems as projection on db.BookingItems;
}
