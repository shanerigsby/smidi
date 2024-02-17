import Foundation
import CoreMIDI


enum MIDICommand: String {
    case cc
    case on
    case off
    case sysex
}

func sendMIDI(command: MIDICommand, data1: UInt8, data2: UInt8) {
    switch command {
        case MIDICommand.cc:
            sendCC(controlNumber: data1, controlValue: data2)
            break
        case MIDICommand.on:
            sendNote(note: data1, velocity: data2, noteOff: false)
            break
        case MIDICommand.off:
            sendNote(note: data1, velocity: data2, noteOff: true)
            break
        case MIDICommand.sysex:
            sendSysex()
            break
    }
}

func printUsage() {
    print("Usage: smidi <data1> <data2> <command>")
    print("Commands:")
    print("  <cc_command> <value> cc")
    print("  <note_number> <velocity> on")
    print("  <note_number> <velocity> off")
    print("  <sysex not yet implemented> sysex")
}

// --------------------------------------------------------
// main execution
//---------------------------------------------------------

let args = CommandLine.arguments

guard args.count == 4 else {
    printUsage()
    exit(1)
}

guard let command = MIDICommand(rawValue: args[3]) else {
    print("Invalid command.")
    printUsage()
    exit(1)
}

guard let data1: UInt8 = UInt8(args[1]), let data2: UInt8 = UInt8(args[2]) else {
    print("Invalid data format.")
    printUsage()
    exit(1)
}

sendMIDI(command: command, data1: data1, data2: data2)
