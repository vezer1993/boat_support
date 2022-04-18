import 'package:boat_support/constants/strings.dart';
import 'package:boat_support/models/check_in_segment.dart';

class CheckInModel{
  List<CheckInSegment> checklist = [];
  String xSets = "10";

  CheckInModel(){

    CheckInSegment item0 = CheckInSegment("Welcome to "+ Strings.charterName, "Welcome to the Check In procedure. During the following procedure you will be asked to check all important segments of the boat one by one, It is your job to inspect each part and acknowledge that it works properly or is accounted for. If you have any questions please contact the number in the top right corner.", [], true);
    checklist.add(item0);

    //engine and cooling system inspection
    CheckInSegment item1 = CheckInSegment("Engine and Cooling System Inspection", "Please check that the engine start properly and that the cooling system works", ["assets/images/EngineStart"], true);
    checklist.add(item1);

    //Bowthrusters
    CheckInSegment item2 = CheckInSegment("Bowthrusters", "Check that the Bowthrusters turn on properly and that both left and right thruster works.", [], true);
    checklist.add(item2);

    //Platform and Ladder
    CheckInSegment item3 = CheckInSegment("Platform and Ladder", "Please Ensure that the Platform and Ladder functions properly", [], true);
    checklist.add(item3);


    //Outside Shower
    CheckInSegment item4 = CheckInSegment("Outside Shower", "Check that the outside shower works", [], true);
    checklist.add(item4);

    //Plotter, Gps & Autopilot
    CheckInSegment item5 = CheckInSegment("Plotter, Gps & Autopilot", "Please check that the Plotter, GPS and the Autopilot are in place and that they work properly", [], true);
    checklist.add(item5);

    //Measuring Device
    CheckInSegment item6 = CheckInSegment("Measuring Device", "Please inspect the Measuring device", [], true);
    checklist.add(item6);

    //Bimini & Sprayhood
    CheckInSegment item7 = CheckInSegment("Bimini & Sprayhood", "Please inspect the Bimini & Sprayhood and that they work properly", [], true);
    checklist.add(item7);

    //Winches
    CheckInSegment item8 = CheckInSegment("Winches", "Inspect that all the Winches are undamaged and functional", [], true);
    checklist.add(item8);

    //Sails and Ropes
    CheckInSegment item9 = CheckInSegment("Sails & Ropes", "Make sure that you have all the Sails and Ropes needed for the trip", [], true);
    checklist.add(item9);

    //Sails and Ropes
    CheckInSegment item10 = CheckInSegment("Docking ROpes", "Inspect that the Docking Ropes are in place and undamaged", [], true);
    checklist.add(item10);

    //Anchor, Anchor Mechanism & Chain
    CheckInSegment item11 = CheckInSegment("Anchor, Anchor Mechanism & Chain", "Check that the Anchor is in place, that Anchor Mechanism works properly and that the chain is undamaged and in place", [], true);
    checklist.add(item11);

    //Outside Inventory
    CheckInSegment item12 = CheckInSegment("Outside Inventory", "Check that all the proper outside equipment is ready", [], true);
    checklist.add(item12);

    //State of Fence & Lifeline
    CheckInSegment item13 = CheckInSegment("State of Fence & Lifeline", "Ensure that the Fence & Lifeline are both undamaged and ready", [], true);
    checklist.add(item13);

    //Outside Engine
    CheckInSegment item14 = CheckInSegment("Outside Engine", "Please check up on the Outside and Engine and make sure it works properly", [], true);
    checklist.add(item14);

    //Dock Fenders
    CheckInSegment item15 = CheckInSegment("Dock Fenders", "Ensure that all Dock Fenders are in place and in good state", [], true);
    checklist.add(item15);

    //Table State & Outside Pillows
    CheckInSegment item16 = CheckInSegment("Table State & Outside Pillows", "Check the state of the outside table & Pillows", [], true);
    checklist.add(item16);

    //Grapple
    CheckInSegment item17 = CheckInSegment("Grapple","Make Sure that the boat is equipped with a Grapple", [], true);
    checklist.add(item17);

    //Dinghy
    CheckInSegment item18 = CheckInSegment("Dinghy","Inspect that the Dinghy is in place and undamaged", [], true);
    checklist.add(item18);

    //Gas
    CheckInSegment item19 = CheckInSegment("Gas","Make sure that the Gas is in place and filled", [], true);
    checklist.add(item19);

    //Visual Engine Inspection
    CheckInSegment item20 = CheckInSegment("Visual Engine Inspection","Inspect the Engine and make sure everything looks correct visually and there is no damage to the exterior of the Engine", [], false);
    checklist.add(item20);

    //Water Pump
    CheckInSegment item21 = CheckInSegment("Water Pump","Inspect the Water Pump and make sure it works correctly", [], false);
    checklist.add(item21);

    //Bilge Pump
    CheckInSegment item22 = CheckInSegment("Bilge Pump","Inspect the Bilge Pump and make sure it works correctly", [], false);
    checklist.add(item22);

    //Waste Pump
    CheckInSegment item23 = CheckInSegment("Waste Pump","Inspect the Waste Pump and make sure it works correctly", [], false);
    checklist.add(item23);

    //Shower Pump
    CheckInSegment item24 = CheckInSegment("Shower Pump","Inspect the Shower Pump and make sure it works correctly", [], false);
    checklist.add(item24);

    //Waste Tank
    CheckInSegment item25 = CheckInSegment("Waste Tank","Inspect the Waste Tank and make sure it's empty", [], false);
    checklist.add(item25);

    //Dishes & Cutlery
    CheckInSegment item26 = CheckInSegment("Dishes & Cutlery","Check that all the sets of Dishes & Cutlery are present and everything is clean", [], false);
    checklist.add(item26);

    //Table
    CheckInSegment item27 = CheckInSegment("Table","Check that the table is undamaged and is clean", [], false);
    checklist.add(item27);

    //Battery & Accumulator
    CheckInSegment item28 = CheckInSegment("Battery & Accumulator","Inspect and check that the Battery & Accumulator work correctly", [], false);
    checklist.add(item28);

    //Lights
    CheckInSegment item29 = CheckInSegment("Lights", "Inspect that all the lights on the boat work correctly", [], false);
    checklist.add(item29);

    //Windows
    CheckInSegment item30 = CheckInSegment("Windows", "Inspect all the Windows & make sure they are undamaged and open/close correctly", [], false);
    checklist.add(item30);

    //Oven
    CheckInSegment item31 = CheckInSegment("Oven", "Inspect that the oven is clean, works correctly and is undamaged", [], false);
    checklist.add(item31);

    //Water check in the ships hull
    CheckInSegment item32 = CheckInSegment("Water check in the ships hull", "Check that there is no watter in the ships hull", [], false);
    checklist.add(item32);

    //Tools
    CheckInSegment item33 = CheckInSegment("Tools", "Check that the tools are all in place", [], false);
    checklist.add(item33);

    //Lifelinks & Harnesses
    CheckInSegment item34 = CheckInSegment("Lifelinks & Harnesses", "Check that there is exactly " + xSets + "x sets of Lifelinks & Harnesses", [], false);
    checklist.add(item34);

    //Lifevests
    CheckInSegment item35 = CheckInSegment("Lifevests", "Check that there is exactly " + xSets + "x sets of Lifevests", [], false);
    checklist.add(item35);

    //First Aid Kit
    CheckInSegment item36 = CheckInSegment("First Aid Kit", "Check that the First Aid Kit is accounted for and in tact", [], false);
    checklist.add(item36);

    //Dinghy Repair Kit
    CheckInSegment item37 = CheckInSegment("Dinghy Repair Kit", "Inspect that the Dingy Repair Kit is accounted for", [], false);
    checklist.add(item37);

    //Pyrotechnics
    CheckInSegment item38 = CheckInSegment("Pyrotechnics", "Inspect the Pyrotechnics and make sure everything is unused", [], false);
    checklist.add(item38);

    //USB Torch
    CheckInSegment item39 = CheckInSegment("USB Torch", "Check the USB Torch and make sure it works properly", [], false);
    checklist.add(item39);

    //Power Bank
    CheckInSegment item40 = CheckInSegment("Power Bank", "Inspect the Power Bank and make sure it works correctly", [], false);
    checklist.add(item40);

    //Binoculars
    CheckInSegment item41 = CheckInSegment("Binoculars", "Check that the Binoculars are on the boat and are undamaged", [], false);
    checklist.add(item41);

    //Compass
    CheckInSegment item42 = CheckInSegment("Compass", "Check that the Compass are on the boat and are undamaged", [], false);
    checklist.add(item42);

    //Charts & Signalling
    CheckInSegment item43 = CheckInSegment("Charts & Signalling", "Inspect the Charts & Signalling and make sure everything is there", [], false);
    checklist.add(item43);

    //Spare Parts (Impellers & Straps)
    CheckInSegment item44 = CheckInSegment("Spare Parts (Impellers & Straps)", "Make sure there are Spare Parts of Impellers & Straps", [], false);
    checklist.add(item44);

    //Fuse
    CheckInSegment item45 = CheckInSegment("Fuses", "Inspect the Fuses and make sure all work", [], false);
    checklist.add(item45);

    //Fuel Level
    CheckInSegment item46 = CheckInSegment("Fuel Level", "Check that the fuel is filled", [], false);
    checklist.add(item46);

    //Day Signs
    CheckInSegment item47 = CheckInSegment("Day Signs", "Check that all Day Signs are in place", [], false);
    checklist.add(item47);

    //Doors Knobs & Locks
    CheckInSegment item48 = CheckInSegment("Doors Knobs & Locks", "Inspect that all Door Knobs & Locks work properly", [], false);
    checklist.add(item48);

    //Entry Cover(Key & Lock)
    CheckInSegment item49 = CheckInSegment("Entry Cover(Key & Lock)", "Inspect the Entry Lock Works properly, make sure the Cover is undamaged and the Keys are present", [], false);
    checklist.add(item49);

    //Faucet
    CheckInSegment item50 = CheckInSegment("Faucet", "Inspect the Faucets and make sure they are in a good condition", [], false);
    checklist.add(item50);

    //Kitchen Inventory
    CheckInSegment item51 = CheckInSegment("Kitchen Inventory", "Inspect the Kitchen Inventory and make sure there is exactly " + xSets + "x sets present", [], false);
    checklist.add(item51);

  }
}