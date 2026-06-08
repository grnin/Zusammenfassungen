

// Demo vl9
```tsx
import { useReducer } from 'react';

type ReducerActionTypes = 'increment' | 'decrement';

const reducer = (
  state: { count: number }, // state ist Zahl von counter
  action: { type: ReducerActionTypes }, // + oder -
) => {
  switch (action.type) {
    case 'increment':
      console.log('incrementing');
      return { count: state.count + 1 };
    case 'decrement':
      console.log('decrementing');
      return { count: state.count - 1 };
    default:
      throw new Error('Unknown action type');
  }
};

export const StaticCounter = () => {
  const actions: Record<'type', ReducerActionTypes>[] = [
    { type: 'increment' },
    { type: 'increment' },
    { type: 'increment' },
    { type: 'decrement' },
  ];

  // static use of the reducer
  const finalState = actions.reduce(reducer, { count: 0 });
  return <p>static reducer result: {finalState.count}</p>;
};

export const Counter = () => {
  // use reducer with useReducer hook
  const [state, dispatch] = useReducer(reducer, { count: 0 });

  return (
    <div>
      <h3>useReducer</h3>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'decrement' })}>[ - ]</button>
      <button onClick={() => dispatch({ type: 'increment' })}>[ + ]</button>
    </div>
  );
};
```
