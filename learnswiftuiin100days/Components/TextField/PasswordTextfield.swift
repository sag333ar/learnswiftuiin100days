import SwiftUI

struct IVTextField: View {
    @Binding var text: String
    @State private var isSecure: Bool = false
    @State private var isError: Bool = false
    @State private var isSuccess: Bool = false
    @State private var errorMessage: String = ""
    @State private var successMessage:String = ""
    
    var placeholder: String
    var title: String
    var isPasswordField: Bool
    var validation: ((String) -> (errorMessage: String?, successMessage: String?)?)?
    
//    init(
//        text: Binding<String>,
//        placeholder: String,
//        title: String,
//        isSecure: Bool = false,
//        validation: ((String) -> (errorMessage: String?, successMessage: String?)?)? = nil
//    ) {
//        self._text = text
//        self.placeholder = placeholder
//        self.title = title
//        self.isSecure = isSecure
//        self.validation = validation
//        self.isPasswordField
//    }
    
    private func validate() {
        if let validation = validation {
            if let result = validation(text) {
                isError = result.errorMessage != nil && !(result.errorMessage?.isEmpty ?? true)
                isSuccess = result.errorMessage == nil
                if isError {
                    errorMessage = result.errorMessage ?? ""
                }
                if isSuccess {
                    successMessage = result.successMessage?.isEmpty ?? true ? "Looks Good" : result.successMessage ?? "Looks Good"
                    
                }
            } else {
                onSuccessValidation()
            }
        } else {
            onSuccessValidation()
        }
    }
    
    private func onSuccessValidation() {
        isError = false
        isSuccess = true
        errorMessage = ""
        successMessage = "Looks Good"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Group {
                    HStack {
                        if isSecure  {
                            TextField(placeholder, text: $text)
                                .onChange(of: text, perform: { _ in
                                    validate()
                                })
                        } else {
                            SecureField(placeholder, text: $text)
                                .onChange(of: text, perform: { _ in
                                    validate()
                                })
                        }
                        
                        if isPasswordField {
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    .padding(.all, 10)
                    .padding(.top, 20)
                    .background(RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(isError ? Color.red : isSuccess ? Color.green : Color.gray, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 6)
                            .fill(isError ? Color.red.opacity(0.1) : isSuccess ? Color.green.opacity(0.1) : Color.clear)
                        )
                    )
                    
                    Text(title)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("primaryColor"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                }
            }
            
            if isError {
                HStack {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .padding(.trailing, 5)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            } else if isSuccess {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .padding(.trailing, 5)
                    Text(successMessage)
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
    }
}
