import Foundation
import CoreMIDI


enum MIDIDestinationError: Error {
    case destinationNotFound
}

class MidiConfig {
    var IACPort: String = "Bus 1"
    var midiChannel: UInt8 = 0
    var outputPort: MIDIPortRef = 0
    var IACDestination: MIDIEndpointRef = 0

    init(IACPort: String, midiChannel: UInt8) {
        do {
            self.IACDestination = try getIACDestination()
        } catch {
            fatalError("Exiting program due to error in setting up IAC destination. \(error)")
        }
        self.IACPort = IACPort
        self.midiChannel = midiChannel
        MIDIClientCreate("swift_client" as CFString, nil, nil, &outputPort)
        MIDIOutputPortCreate(outputPort, "swift_client_out" as CFString, &outputPort)
    }

    func getIACDestination() throws -> MIDIEndpointRef {
        let destinationCount = MIDIGetNumberOfDestinations()
        for i in 0..<destinationCount {
            let destination = MIDIGetDestination(i)
            var name: Unmanaged<CFString>?
            MIDIObjectGetStringProperty(destination, kMIDIPropertyName, &name)
            let destinationName = name!.takeRetainedValue() as String
            if destinationName == IACPort {
                return destination
            }
        }
        throw MIDIDestinationError.destinationNotFound
    }
}