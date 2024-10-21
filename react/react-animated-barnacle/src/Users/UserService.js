import User from './UserModel';

class UserService {
    constructor() {
      this.baseUrl = "http://127.0.0.1:8080/users";
      this.user = null; 
      this.users = [];  
    }
  
    showErrorDialog(message) {
      alert(`Error: ${message}`);
    }
  
    showSuccessDialog(message) {
      alert(`Success: ${message}`);
    }
  
    async createUser(username, email, password) {
      try {
        const response = await fetch(`${this.baseUrl}/create`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({ username, email, password }),
        });
  
        if (response.ok) {
          const data = await response.json();
          this.user = User.fromJson(data);
          this.showSuccessDialog("User created successfully!");
          return true;
        } else {
          this.showErrorDialog("Failed to create user.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  
    async authenticateUser(username, password) {
      try {
        const response = await fetch(`${this.baseUrl}/auth`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({ username, password }),
        });
  
        const data = await response.json();
  
        // Assuming 'jwt' is included in the response
        if (data.jwt) {
          localStorage.setItem('jwt', data.jwt); // Store token in local storage
          return true;
        } else {
          this.showErrorDialog("Authentication failed.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  
    async getUser(id) {
      try {
        const response = await fetch(`${this.baseUrl}/${id}`);
  
        if (response.ok) {
          const data = await response.json();
          this.user = User.fromJson(data);
          return true;
        } else {
          this.showErrorDialog("Failed to fetch user.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  
    async getAllUsers() {
      try {
        const response = await fetch(this.baseUrl);
  
        if (response.ok) {
          const data = await response.json();
          this.users = data.map(userJson => User.fromJson(userJson));
          return true;
        } else {
          this.showErrorDialog("Failed to fetch users.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  
    async updateUser(user) {
      try {
        const response = await fetch(`${this.baseUrl}/${user.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            username: user.username,
            email: user.email,
          }),
        });
  
        if (response.ok) {
          this.showSuccessDialog("User updated successfully!");
          return true;
        } else {
          this.showErrorDialog("Failed to update user.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  
    async deleteUser(id) {
      try {
        const response = await fetch(`${this.baseUrl}/${id}`, {
          method: 'DELETE',
        });
  
        if (response.ok) {
          this.showSuccessDialog("User deleted successfully!");
          return true;
        } else {
          this.showErrorDialog("Failed to delete user.");
          return false;
        }
      } catch (error) {
        this.showErrorDialog(`Error: ${error.message}`);
        return false;
      }
    }
  }

  export default UserService;