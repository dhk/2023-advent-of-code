import React, { useState } from 'react';

function App() {
  const [inputData, setInputData] = useState('');
  const [result, setResult] = useState(null);

  const isGamePossible = (game, maxRed, maxGreen, maxBlue) => {
    for (const subset of game) {
      if ((subset.red || 0) > maxRed || (subset.green || 0) > maxGreen || (subset.blue || 0) > maxBlue) {
        return false;
      }
    }
    return true;
  };

  const parseGame = (gameString) => {
    const [idPart, subsetsPart] = gameString.split(': ');
    const gameId = parseInt(idPart.split(' ')[1]);
    const subsets = subsetsPart.split('; ').map(subset => {
      const cubes = subset.split(', ');
      return cubes.reduce((acc, cube) => {
        const [count, color] = cube.split(' ');
        acc[color] = parseInt(count);
        return acc;
      }, {});
    });
    return [gameId, subsets];
  };

  const sumPossibleGameIds = (gamesData, maxRed, maxGreen, maxBlue) => {
    let totalSum = 0;
    const games = gamesData.trim().split('\n');
    for (const game of games) {
      const [gameId, parsedGame] = parseGame(game);
      if (isGamePossible(parsedGame, maxRed, maxGreen, maxBlue)) {
        totalSum += gameId;
      }
    }
    return totalSum;
  };

  const handleSolve = () => {
    const sum = sumPossibleGameIds(inputData, 12, 13, 14);
    setResult(sum);
  };

  return (
    <div style={{
      fontFamily: 'Arial, sans-serif',
      maxWidth: '600px',
      margin: '0 auto',
      padding: '20px',
      backgroundColor: '#f0f4f8',
      borderRadius: '8px',
      boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
    }}>
      <h1 style={{ color: '#2c3e50', textAlign: 'center' }}>Cube Game Solver</h1>
      <textarea
        value={inputData}
        onChange={(e) => setInputData(e.target.value)}
        placeholder="Paste your game data here..."
        style={{
          width: '100%',
          height: '200px',
          padding: '10px',
          marginBottom: '20px',
          borderRadius: '4px',
          border: '1px solid #bdc3c7',
          fontSize: '14px'
        }}
      />
      <button
        onClick={handleSolve}
        style={{
          backgroundColor: '#3498db',
          color: 'white',
          padding: '10px 20px',
          border: 'none',
          borderRadius: '4px',
          fontSize: '16px',
          cursor: 'pointer'
        }}
      >
        Solve
      </button>
      {result !== null && (
        <div style={{
          marginTop: '20px',
          padding: '15px',
          backgroundColor: 'white',
          borderRadius: '4px',
          boxShadow: '0 1px 3px rgba(0,0,0,0.1)'
        }}>
          <h2 style={{ color: '#2c3e50', marginTop: '0' }}>Result</h2>
          <p style={{ fontSize: '18px', fontWeight: 'bold' }}>
            Sum of IDs of possible games: {result}
          </p>
        </div>
      )}
    </div>
  );
}

export default App;