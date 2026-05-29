using {
    cuid,
    managed
} from '@sap/cds/common';

namespace airline.db;

entity Airports : cuid, managed {
    airportCode : String(10);
    airportName : String(100);
    city        : String(100);
    country     : String(100);
}

entity Flights : cuid, managed {
    flightNumber       : String(20);
    airlineName        : String(100);
    sourceAirport      : Association to Airports;
    destinationAirport : Association to Airports;
    departureTime      : Timestamp;
    arrivalTime        : Timestamp;
    totalSeats         : Integer;
    availableSeats     : Integer;
    ticketPrice        : Decimal(10, 2);
    status             : FlightStatus default 'SCHEDULED';
}

entity Passengers : cuid, managed {
    firstName      : String(100);
    lastName       : String(100);
    email          : String(150);
    passportNumber : String(50);
    nationality    : String(50);
    dateOfBirth    : Date;
}

entity Bookings : cuid, managed {
    bookingNumber : String(30);
    flight        : Association to Flights;
    passengers    : Association to Passengers;
    bookingDate   : Timestamp;
    seatNumber    : String(10);
    bookingStatus : BookingStatus default 'CONFIRMED';
    amountPaid    : Decimal(10, 2);
    bookingItems  : Composition of many BookingItems on bookingItems.booking = $self;
}

entity BookingItems : cuid {
    booking        : Association to Bookings;
    mealType       : String(50);
    baggageWeight  : Decimal(5, 2);
    specialRequest : String(255);
}

type FlightStatus  : String enum {
    SCHEDULED;
    DELAYED;
    CANCELLED;
    COMPLETED;
}

type BookingStatus : String enum {
    CONFIRMED;
    CANCELLED;
    PENDING;
}
