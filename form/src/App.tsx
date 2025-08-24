import './App.css'
import 'react-toastify/dist/ReactToastify.css';
import Form from './pages/Form'
import { ToastContainer } from "react-toastify";

function App() {

  return (
    <>
      <Form />
      <ToastContainer />
    </>
  )
}

export default App;