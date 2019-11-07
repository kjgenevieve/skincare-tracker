import React from "react";
import { BrowserRouter as Router } from 'react-router-dom'
import "./App.css";
import { Container } from 'semantic-ui-react';
import NavBar from "./components/NavBar";
import Main from "./containers/Main";

function App() {
  return (
    <div>
        <Router>
          <NavBar />
          <Container>
            <Main />
          </Container>
        </Router>
    </div>
  );
}

export default App;
