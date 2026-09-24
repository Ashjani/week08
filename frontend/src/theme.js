import { createTheme } from "@mui/material/styles";

const theme = createTheme({
  palette: {
    primary: {
      main: "#E65100",
    },
    secondary: {
      main: "#6A1B9A",
    },
    background: {
      default: "#f5f5f5",
    },
  },

  typography: {
    fontFamily: "Roboto, Arial, sans-serif",
  },

  shape: {
    borderRadius: 8,
  },
});

export default theme;