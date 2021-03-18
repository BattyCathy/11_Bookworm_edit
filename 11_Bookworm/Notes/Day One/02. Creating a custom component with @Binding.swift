//
//  02. Crating a custom component with @Binding.swift
//  11_Bookworm
//
//  Created by Austin Roach on 3/17/21.
//

import Foundation

//You've already seen how SwiftUI's @State property wrapper lets us work with local value types, and how @ObservableObject lets us work with shareable reference types. Well, there's a third option, called @Binding, which lets us connect an @State property of one view to some underlying model data.

//Think about it: when we create a toggle switch we sens in some sort of Boolean property that can be changed, like this:

/*
 @State private var rememberMe = false
 
 var body: some View {
    Toggle(isOn: $rememberMe) {
        Text("Remember Me")
    }
 }
 */

//So, the toggle needs to change our Boolean when the user interacts with it, but how does it remember what value should change?

//That's where @Binding comes in: it lets us create a mutable value in a view, that acutally points to some other value from elsewhere. In the case of Toggle, the switch changes its own local binding to a Boolean, but behind the scenes that's actually manipulating the @State property in our view.

//This makes @Binding extremely important for whenever you want to create a custom user interface component. At their core, UI components are just SwiftUI views like eveything else, but @Binding properties that let them interface directly with other views.

//To demonstrate this, we're going to create a new kind of button: one that stays down when pressed. Our basic implementation will all be stuff you've seen before: a button with some padding, a linear gradient for the background, a Capsule clip shape, and so on - add this to ContentView.swift now:

/*
 struct PushButton: View {
    let title: String
    @State var isOn: Bool
 
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
 
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
 }
 */

//The only vaguely exciting thing in there is that I used properties for the two gradient colors so they can be customized by whatever creates the button.

//We can now create one of those buttons as part of our main user interface, like this:

/*
 struct ContentView: View {
    @State private var rememberMe = false
 
    var body: some View {
        VStack {
            PushBotton(title: "Remember me", isOn: rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
 }
 */

//That has a text view below the button so we can track the state of the button - try running your code and see how it works.

//What you'll find is that tapping tha button does indeed affect the way it apears, but our text view doesn't reflect that change - it always says "Off". Clearly something is changing because the button's appearance changes when it's pressed, but that change isn't being reflected in ContentView.

//What's happening here is that we've defined a one-way flow of data: ContentView has its rememeberMe Boolean, which gets used to create a PushButton - the button has an initial value provided by ContentView. however, once the button was created it takes over control of the valu: it toggles the isOn propertyy betweeen true and false internally to the button, but doens't pass that change back on to ContentView.

//This is a problem, because we now have two sources of truth: Contentview is storing one values, and PushButton anoter. Fortunately, this is where @Binding comes in: it allows us to create a two-way connection between PushButton and whatever is using it, so that when one value changes the other does too.

//To switch over to @Binding we need to make just two changes. First, in PushButton change its isOn property to this:

//@Binding var isOn: Bool

//And second, in ContentView change the wy we create the button to this:

//PushButton(title: "Remember Me", isOn: $rememberMe)

//That adds a dollar sign before rememberMe - we're passing in the binding itself, not the boolean inside it.

//Now run the code again, and you'll find that everything works as expected: toggling the button now correctly updates the text view as well.

//This is the power of @Binding: as far as the button is concerned it' just toggling a Boolean - it has no idea that something else is monitoring that Boolean and acting upon changes. 
