import React, { useState } from 'react';
import UserService from './UserService';  // Import your UserService

const LoginView = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState(null);  

  const userService = new UserService();

  const handleLogin = async (e) => {
    e.preventDefault();  
    setError(null); 

    if (!username || !password) {
      setError('Please complete the form.');
    } else {
      const loggedIn = await userService.authenticateUser(username, password);

      if (loggedIn) {
        console.log('Successfully authenticated user!');
      } else {
        setError('Error logging in!');
      }
    }
  };

  return (
    <div style={{ maxWidth: '400px', margin: 'auto', padding: '20px' }}>
      <h1 style={{ textAlign: 'center', fontStyle: 'italic' }}>Login</h1>

      {error && (
        <div style={{ color: 'red', marginBottom: '16px' }}>
          {error}
        </div>
      )}

      <form onSubmit={handleLogin}>
        {/* Username Field */}
        <div style={{ marginBottom: '16px' }}>
          <label htmlFor="username">Username</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            placeholder="Enter your username"
            style={{
              width: '100%',
              padding: '10px',
              border: '1px solid #ccc',
              borderRadius: '4px',
            }}
          />
        </div>

        {/* Password Field */}
        <div style={{ marginBottom: '16px' }}>
          <label htmlFor="password">Password</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Enter your password"
            style={{
              width: '100%',
              padding: '10px',
              border: '1px solid #ccc',
              borderRadius: '4px',
            }}
          />
        </div>

        <button
          type="submit"
          style={{
            width: '100%',
            padding: '10px',
            backgroundColor: '#007BFF',
            color: 'white',
            border: 'none',
            borderRadius: '4px',
            cursor: 'pointer',
          }}
        >
          Submit
        </button>
      </form>
    </div>
  );
};

export default LoginView;
