import Foundation
import CoreMIDI

// -- setup
let IACPort = "Bus 1"
let midiChannel: UInt8 = 0
let config = MidiConfig(IACPort: IACPort, midiChannel: midiChannel)
//

func sendCC(controlNumber: UInt8, controlValue: UInt8) {
    var packet = MIDIPacket()
    packet.timeStamp = 0
    packet.length = 3
    packet.data.0 = 0xB0 | config.midiChannel  // Control Change command with channel
    packet.data.1 = controlNumber
    packet.data.2 = controlValue

    var packetList = MIDIPacketList(numPackets: 1, packet: packet)
    print("\(controlNumber) | \(controlValue) [CC | \(config.IACDestination)]")
    MIDISend(config.outputPort, config.IACDestination, &packetList)
}

func sendNote(note: UInt8, velocity: UInt8, noteOff: Bool) {
    let commandByte: UInt8 = noteOff ? 0x80 : 0x90
    let commandEnglish: String = noteOff ? "NoteOff" : "NoteOn"
    var packet: MIDIPacket = MIDIPacket()
    packet.timeStamp = 0
    packet.length = 3
    packet.data.0 = commandByte | config.midiChannel // Note-on/off command with channel
    packet.data.1 = note
    packet.data.2 = velocity

    var packetList = MIDIPacketList(numPackets: 1, packet: packet)
    print("\(note) | \(velocity) [\(commandEnglish) | \(config.IACDestination)]")
    MIDISend(config.outputPort, config.IACDestination, &packetList)
}

func sendSysex() {
    print("Send sysex not implemented")
}