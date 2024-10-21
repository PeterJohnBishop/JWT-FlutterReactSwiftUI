class User {
    constructor(id, username, email, password) {
      this.id = id || ""; 
      this.username = username;
      this.email = email;
      this.password = password; 
    }
  
    // Method to convert JSON data into a User object
    static fromJson(json) {
      return new User(
        json._id,          
        json.username,
        json.email,
        json.password      
      );
    }
  
    // Method to convert a User object into JSON
    toJson() {
      return {
        username: this.username,
        email: this.email,
        password: this.password 
      };
    }
};

export default User;