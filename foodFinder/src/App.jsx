import React, { useState } from "react";
import { Search, Utensils, DollarSign, MapPin, Heart, List, AlertTriangle } from 'lucide-react';
import logo from './assets/logo.png';
function App() {
  const [results, setResults] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const [form, setForm] = useState({
    taste: "_",
    cuisine: "_",
    budget: "_",
    city: "_",
  });

  const tasteOptions = [
    { value: "spicy", label: "Spicy" },
    { value: "sweet", label: "Sweet" },
    { value: "mild", label: "Mild" },
    { value: "savory", label: "Savory" },
  ];
  const cuisineOptions = [
    { value: "sri_lankan", label: "Sri Lankan" },
    { value: "indian", label: "Indian" },
    { value: "italian", label: "Italian" },
    { value: "japanese", label: "Japanese" },
    { value: "chinese", label: "Chinese" },
    { value: "seafood", label: "Seafood" },
    { value: "dessert", label: "Dessert" },
    { value: "vegetarian", label: "Vegetarian" },
    { value: "fast_food", label: "Fast Food" },
    { value: "thai", label: "Thai" },
  ];
  const budgetOptions = [
    { value: "low", label: "Low ($)" },
    { value: "medium", label: "Medium ($$)" },
    { value: "high", label: "High ($$$)" },
  ];
  const cityOptions = [
    { value: "colombo", label: "Colombo" },
    { value: "kandy", label: "Kandy" },
    { value: "galle", label: "Galle" },
    { value: "negombo", label: "Negombo" },
    { value: "jaffna", label: "Jaffna" },
    { value: "matara", label: "Matara" },
  ];

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const search = async () => {
    setLoading(true);
    setError(null);
    setResults([]);
    try {
      const res = await fetch("http://localhost:8080/recommend", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      if (!res.ok) throw new Error(`HTTP error! Status: ${res.status}`);
      const data = await res.json();
      setResults(data.results || []);
    } catch (err) {
      console.error("Fetch Error:", err);
      setError("Could not connect to the Prolog server. Ensure it is running on http://localhost:8080.");
    } finally { setLoading(false); }
  };

  const SelectInput = ({ label, name, icon: Icon, options }) => (
    <div className="flex flex-col space-y-2">
      <label htmlFor={name} className="flex items-center text-xl font-bold text-green-500 gap-2">
        <Icon size={16} className="mr-2 text-orange-300 w-6 h-auto" />
        {label}
      </label>
      <select
        id={name}
        name={name}
        value={form[name]}
        onChange={handleChange}
        className="mt-1 block w-full pl-3 pr-10 py-2 text-base bg-gray-800 text-gray-100 border-gray-700 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 transition duration-150 ease-in-out cursor-pointer"
      >
        <option value="_">Any</option>
        {options.map(option => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
    </div>
  );

  const formatValue = (value) => value.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());

  return (
    <div className="min-h-screen bg-gray-900 p-4 sm:p-8 font-sans text-gray-200">
      <div className="max-w-5xl mx-auto bg-gray-800 p-6 sm:p-10 rounded-2xl shadow-2xl border border-gray-700">
        

       
        <h1 className="text-3xl sm:text-4xl font-extrabold text-center text-emerald-300 mb-8 flex items-center justify-center gap-8 ">
          <img src={logo} alt="" className="w-32 h-auto -mt-4 "   />
          Sri Lankan Restaurant Finder
        </h1>


  <p className="w-full h-12"></p>
        {/* Filter Controls */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8 p-8 bg-gray-700 rounded-lg border border-gray-600   ">
          <SelectInput label="Taste Preference" name="taste" icon={Heart} options={tasteOptions} />
          <SelectInput label="Cuisine Type" name="cuisine" icon={Utensils} options={cuisineOptions} />
          <SelectInput label="Budget Level" name="budget" icon={DollarSign} options={budgetOptions} />
          <SelectInput label="City" name="city" icon={MapPin} options={cityOptions} />
        </div>

        {/* Search Button */}
        <div className="flex justify-center mb-10">
          <button
            onClick={search}
            disabled={loading}
            className="flex items-center justify-center px-8 py-3 border border-transparent text-base font-bold rounded-full shadow-lg text-gray-900 bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-4 focus:ring-indigo-300 transition duration-150 ease-in-out disabled:bg-gray-600"
          >
            {loading ? (
              <>
                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-gray-900" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Searching...
              </>
            ) : (
              <>
                <Search size={20} className="mr-2" />
                Find Restaurants
              </>
            )}
          </button>
        </div>
        
        {/* Results Section */}
        <h2 className="text-2xl font-semibold text-gray-200 border-b border-gray-600 pb-2 mb-6 flex items-center">
            <List size={24} className="mr-2 text-gray-400" />
            Recommendations
        </h2>

        {error && (
          <div className="p-4 mb-4 text-sm text-red-400 bg-red-900 rounded-lg flex items-center">
            <AlertTriangle size={20} className="mr-2" />
            {error}
          </div>
        )}

        {!loading && !error && (
          <div className="space-y-4">
            {results.length === 0 ? (
              <p className="text-gray-400 italic text-center p-4 bg-gray-700 rounded-lg">
                {results.length === 0 && (form.taste === '_' && form.cuisine === '_' && form.budget === '_' && form.city === '_') 
                    ? "Adjust filters to find matching restaurants."
                    : "No restaurants match your current criteria."
                }
              </p>
            ) : (
              <ul className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {results.map((r, i) => (
                  <li key={i} className="bg-gray-950 border border-gray-700 p-4 rounded-lg shadow hover:shadow-xl transition duration-300 transform hover:-translate-y-1">
                    <strong className="text-lg font-bold text-green-500 block mb-1">{r.name}</strong>
                    <div className="text-sm space-y-1 text-gray-200">
                        <p><span className="font-medium">Cuisine:</span> {formatValue(r.cuisine)}</p>
                        <p><span className="font-medium">Taste:</span> {formatValue(r.taste)}</p>
                        <p><span className="font-medium">Budget:</span> {formatValue(r.budget)}</p>
                        <p><span className="font-medium">City:</span> {formatValue(r.city)}</p>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
