import Foundation
import CoreMIDI


enum MIDICommand: String {
    case cc
    case on
    case off
    case sysex
}

func sendMIDI(channel: UInt8, command: MIDICommand, data1: UInt8, data2: UInt8) {
    switch command {
        case MIDICommand.cc:
            sendCC(channel: channel, controlNumber: data1, controlValue: data2)
            break
        case MIDICommand.on:
            sendNote(channel: channel, note: data1, velocity: data2, noteOff: false)
            break
        case MIDICommand.off:
            sendNote(channel: channel, note: data1, velocity: data2, noteOff: true)
            break
        case MIDICommand.sysex:
            sendSysex()
            break
    }
}

func printUsage() {
    print("Usage: smidi <channel> <data1> <data2> <command>")
    print("Commands:")
    print("  <channel> <cc_command> <value> cc")
    print("  <channel> <note_number> <velocity> on")
    print("  <channel> <note_number> <velocity> off")
    //print("  <sysex not yet implemented>")
}

// --------------------------------------------------------
// main execution
//---------------------------------------------------------

let args = CommandLine.arguments

guard args.count == 5 else {
    printUsage()
    exit(1)
}

guard let command = MIDICommand(rawValue: args[4]) else {
    print("Invalid command.")
    printUsage()
    exit(1)
}

guard let channel: UInt8 = UInt8(args[1]), let data1: UInt8 = UInt8(args[2]), let data2: UInt8 = UInt8(args[3]) else {
    print("Invalid data format.")
    printUsage()
    exit(1)
}

sendMIDI(channel: channel, command: command, data1: data1, data2: data2)
